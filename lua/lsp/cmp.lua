local lspkind = require("lspkind")
local cmp = require("cmp")
local snip = require("luasnip")
local s = snip.snippet
local t = snip.text_node
local i = snip.insert_node

snip.add_snippets("all", { s("/", { t({ "/**" }), i(1), t({ "*/" }) }) })

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text",
			maxwidth = 50,
			before = function(entry, vim_item)
				vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
				return vim_item
			end,
		}),
	},

	snippet = {
		expand = function(args)
			snip.lsp_expand(args.body)
		end,
	},
	
	-- 性能优化：减少补全触发频率
	performance = {
		trigger_debounce_time = 300, -- 防抖时间 300ms
		throttle = 60, -- 节流时间 60ms
		fetching_timeout = 500, -- 获取超时 500ms
		max_view_entries = 20, -- 最多显示 20 条结果
	},
	
	-- 来源优化
	sources = cmp.config.sources({
		{ name = "nvim_lsp", priority = 1000, max_item_count = 20 },
		{ name = "luasnip", priority = 750, max_item_count = 5 },
		{ name = "buffer", priority = 500, max_item_count = 10 },
		{ name = "path", priority = 250 },
	}),
	
	-- 只在有输入时才触发补全（避免空行也弹窗）
	enabled = function()
		-- 在 prompt 模式（如 Telescope）中禁用补全
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		if buftype == "prompt" then
			return false
		end
		return true
	end,

	-- 快捷键
	mapping = require("keybindings").cmp(cmp),
	
	-- 补全窗口配置
	window = {
		completion = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None",
			scrollbar = true,
		},
		documentation = {
			border = "rounded",
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			max_width = 80,
			max_height = 15,
		},
	},
	
	-- 实验性功能：预读取选择项
	experimental = {
		ghost_text = false, -- 关闭虚影文本（减少视觉干扰）
	},
})
-- Use buffer source for `/`.
cmp.setup.cmdline("/", { mapping = cmp.mapping.preset.cmdline(), sources = { { name = "buffer" } } })

-- Use cmdline & path source for ':'.

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
