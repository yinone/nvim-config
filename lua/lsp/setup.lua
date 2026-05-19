-- :h mason-default-settings
require("mason").setup({
	ui = {
		icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"vtsls",
		"eslint",
		"bashls",
		"cssls",
		"html",
		"jsonls",
		"yamlls",
		"gopls",
		"vimls",
		"dockerls",
		"marksman",
	},
	automatic_enable = false,
})

-- blink.cmp 提供的 LSP capabilities
local capabilities = require("blink.cmp").get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities())
-- 修复 Neovim 0.11+ position_encoding 警告
capabilities.positionEncoding = { 'utf-8' }
-- 关闭客户端拉取式诊断能力（textDocument/diagnostic）
-- 避免与服务端推送式诊断（publishDiagnostics）同时生效导致诊断重复显示
if capabilities.textDocument then
	capabilities.textDocument.diagnostic = nil
end

-- 基础 on_attach：性能优化 + 通用功能
local function base_on_attach(client, bufnr)
	-- 绑定 LSP 快捷键
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	require('keybindings').mapLSP(buf_set_keymap)
	
	-- navic 支持
	local ok, navic = pcall(require, 'nvim-navic')
	if ok and client.server_capabilities.documentSymbolProvider then
		navic.attach(client, bufnr)
	end

	-- 兜底：移除服务端的拉取式诊断能力声明，确保 Neovim 不走拉取通道
	-- 与上面 capabilities.textDocument.diagnostic = nil 配合，根除诊断重复
	if client.server_capabilities then
		client.server_capabilities.diagnosticProvider = nil
	end
end

-- 包装 on_attach：执行特定配置 + 基础配置
local function wrap_on_attach(specific_on_attach)
	return function(client, bufnr)
		-- 先执行特定配置的 on_attach（如果有）
		if specific_on_attach then
			specific_on_attach(client, bufnr)
		end
		-- 再执行基础 on_attach
		base_on_attach(client, bufnr)
	end
end

-- 获取服务器配置（包装 on_attach）
local function get_server_config(name)
	local ok, config = pcall(require, "lsp.lang." .. name)
	if not ok then
		config = {}
	end
	
	-- 包装 on_attach
	config.on_attach = wrap_on_attach(config.on_attach)
	return config
end

local servers = {
	lua_ls = get_server_config("lua"),
	bashls = get_server_config("bash"),
	vtsls = get_server_config("ts"), -- 替换 ts_ls
	eslint = get_server_config("eslint"), -- 新增
	html = get_server_config("html"),
	cssls = get_server_config("css"),
	jsonls = get_server_config("json"),
	yamlls = get_server_config("yaml"), -- 新增
	vimls = get_server_config("vim"),
	gopls = get_server_config("golang"),
	dockerls = get_server_config("dockerls"), -- 新增（无 lang 文件）
	marksman = get_server_config("marksman"), -- 新增（无 lang 文件）
}

-- 自动安装 LanguageServers
for name, server_config in pairs(servers) do
	if server_config == nil then
		goto continue
	end

	-- 服务器配置已经包含了包装后的 on_attach，只需添加 capabilities
	server_config.capabilities = capabilities

	vim.lsp.config(name, server_config)
	-- Neovim 0.11+ 需要显式启用 LSP
	vim.lsp.enable(name)

	::continue::
end

-- 过滤 TS 诊断 code 80001（"建议使用 require"）+ 按 范围/消息 去重
-- 去重用于消除 gopls 同一问题重复发布（如 staticcheck ST1000）
-- Neovim 0.11+ 推荐写法：包裹原生 publishDiagnostics handler
do
	local orig = vim.lsp.handlers["textDocument/publishDiagnostics"]
	vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, cfg)
		if result and result.diagnostics then
			local filtered = {}
			local seen = {}
			for _, d in ipairs(result.diagnostics) do
				if d.code ~= 80001 then
					-- 以 范围 + 消息 作为唯一键，去掉重复诊断
					local r = d.range or {}
					local s, e = r.start or {}, r["end"] or {}
					local key = table.concat({
						s.line or 0, s.character or 0,
						e.line or 0, e.character or 0,
						d.message or "",
					}, ":")
					if not seen[key] then
						seen[key] = true
						filtered[#filtered + 1] = d
					end
				end
			end
			result.diagnostics = filtered
		end
		return orig(err, result, ctx, cfg)
	end
end
