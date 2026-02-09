-- :h mason-default-settings
require("mason").setup({
	ui = {
		icons = { package_installed = "✓", package_pending = "➜", package_uninstalled = "✗" },
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"ts_ls",
		"bashls",
		"cssls",
		"html",
		"jsonls",
		'gopls',
		"vimls",
		"dockerls",
		"marksman",
		"ruby_lsp",
	},

	automatic_enable = false,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- 修复 Neovim 0.11+ position_encoding 警告
capabilities.positionEncoding = { 'utf-8' }

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

	-- 减少文档同步频率，提升性能
	if client.server_capabilities then
		client.server_capabilities.diagnosticProvider = {
			interFileDependencies = false,
			workspaceDiagnostics = false,
		}
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
	ts_ls = get_server_config("ts"),
	html = get_server_config("html"),
	cssls = get_server_config("css"),
	jsonls = get_server_config("json"),
	vimls = get_server_config("vim"),
	gopls = get_server_config("golang"),
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

-- LSP 全局性能优化
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		-- 延迟诊断更新，提升性能
		update_in_insert = false,
		-- 虚影文本显示诊断
		virtual_text = {
			spacing = 4,
			prefix = "●",
		},
		-- 只在保存后更新诊断（可选，最省性能）
		-- update_in_insert = false,
	}
)
