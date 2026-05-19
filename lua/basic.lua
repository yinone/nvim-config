local opt = vim.opt

opt.encoding    = "UTF-8"
opt.fileencoding = "utf-8"

-- 滚动留边
opt.scrolloff    = 8
opt.sidescrolloff = 8

-- 行号与符号列
opt.number      = true
opt.cursorline  = true
opt.signcolumn  = "yes"
opt.colorcolumn = "100"

-- 缩进（统一用 opt，不要重复用 vim.bo）
opt.tabstop     = 2
opt.softtabstop = 2
opt.shiftwidth  = 2
opt.shiftround  = true
opt.expandtab   = true
opt.autoindent  = true
opt.smartindent = true
opt.smarttab    = true

-- 搜索
opt.ignorecase = true
opt.smartcase  = true
opt.hlsearch   = true
opt.incsearch  = true

-- 折叠（treesitter.lua 会覆盖 foldmethod/foldexpr）
opt.foldenable    = true
opt.foldlevelstart = 99

-- UI
opt.cmdheight   = 1
opt.wrap        = false   -- 默认不自动折行，长行横向滚动更直观
opt.splitbelow  = true
opt.splitright  = true
opt.showmode    = false
opt.showtabline = 2
opt.background  = "dark"
opt.termguicolors = true
opt.pumheight   = 10
opt.wildmenu    = true
opt.list        = false
opt.listchars   = "space:·,tab:>·"

-- 杂项
opt.whichwrap   = "<,>,[,]"
opt.hidden      = true
opt.mouse       = "a"
opt.clipboard   = "unnamedplus"
opt.history     = 1000
opt.autoread    = true
opt.updatetime  = 250
opt.timeoutlen  = 300
opt.redrawtime  = 1500
opt.synmaxcol   = 200
opt.shortmess:append("c")

-- 禁止备份/交换
opt.backup      = false
opt.writebackup = false
opt.swapfile    = false

---- 禁用内置插件（由 lazy.nvim rtp 优化接管，这里双保险）----
vim.g.loaded_gzip              = 1
vim.g.loaded_tar               = 1
vim.g.loaded_tarPlugin         = 1
vim.g.loaded_zip               = 1
vim.g.loaded_zipPlugin         = 1
vim.g.loaded_getscript         = 1
vim.g.loaded_getscriptPlugin   = 1
vim.g.loaded_vimball           = 1
vim.g.loaded_vimballPlugin     = 1
vim.g.loaded_matchit           = 1
vim.g.loaded_matchparen        = 1
vim.g.loaded_2html_plugin      = 1
vim.g.loaded_logiPat           = 1
vim.g.loaded_rrhelper          = 1
vim.g.loaded_netrw             = 1
vim.g.loaded_netrwPlugin       = 1
vim.g.loaded_netrwSettings     = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_remote_plugins    = 1
vim.g.loaded_perl_provider     = 0
vim.g.loaded_ruby_provider     = 0
vim.g.python3_host_prog        = vim.fn.stdpath("data") .. "/python3-provider/bin/python"

vim.g.clipboard = {
	name = "macOS pbcopy",
	copy = {
		["+"] = { "/usr/bin/pbcopy" },
		["*"] = { "/usr/bin/pbcopy" },
	},
	paste = {
		["+"] = { "/usr/bin/pbpaste" },
		["*"] = { "/usr/bin/pbpaste" },
	},
	cache_enabled = 0,
}

vim.g.skip_ts_context_commentstring_module = true

vim.filetype.add({
	extension = {
		gotmpl = "gotmpl",
		mdx = "markdown.mdx",
	},
})

-- 大文件优化已交给 snacks.bigfile 处理
