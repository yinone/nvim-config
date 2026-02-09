-- utf8
-- vim.g.{name}: 全局变量
-- vim.b.{name}: 缓冲区变量
-- vim.w.{name}: 窗口变量
-- vim.bo.{option}: buffer-local 选项
-- vim.wo.{option}: window-local 选项
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
-- 使用行号
vim.wo.number = true
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"
-- 右侧参考线，超过表示代码太长了，考虑换行
vim.wo.colorcolumn = "100"
-- 缩进2个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
vim.o.expandtab = true
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
vim.o.smarttab = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 是否开启代码折叠
vim.o.foldenable = true
vim.o.foldlevelstart = 99
-- vim.o.foldcolumn = '1'

-- 搜索高亮
vim.o.hlsearch = true
-- 边输入边搜索
vim.o.incsearch = true
-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 1
-- 当文件被外部程序修改时，自动加载
vim.o.autoread = true
vim.bo.autoread = true
-- 自动折行
vim.wo.wrap = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a"
-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
-- 性能优化：较小的 updatetime 用于更快的 CursorHold 事件
-- 但不要太小，避免频繁触发
vim.o.updatetime = 250
-- 设置 timeoutlen 为等待键盘快捷键连击时间300毫秒
vim.o.timeoutlen = 300
-- 减少重绘延迟
vim.o.redrawtime = 1500
-- 减少滚动时的偏移
vim.o.sidescrolloff = 5
-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = false
vim.o.listchars = "space:·,tab:>·"
-- 补全增强
vim.o.wildmenu = true
-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"
-- 补全最多显示10行
vim.o.pumheight = 10
-- 永远显示 tabline
vim.o.showtabline = 2
-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false
-- 使用系统剪切板
vim.o.clipboard = "unnamed"
vim.o.history = 1000

---- disable_distribution_plugins ----
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_remote_plugins = 1

vim.g.skip_ts_context_commentstring_module = true

-- 斜体
vim.g.t_ZH = "\\\\e[3m"
vim.g.t_ZR = "\\\\e[23m"
-- 性能优化配置

-- 减少语法高亮的最大行数（提升长行文件性能）
vim.o.synmaxcol = 200

-- 大文件优化：超过 1MB 的文件禁用某些功能
vim.api.nvim_create_autocmd("BufReadPre", {
	callback = function(args)
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > 1024 * 1024 then -- 1MB
			-- 大文件禁用 swap 和 undo
			vim.bo.swapfile = false
			vim.bo.undofile = false
			vim.bo.filetype = ""
			print("Large file mode enabled")
		end
	end,
})

-- 禁用 python3 provider（如果你不需要 python 插件）
-- vim.g.loaded_python3_provider = 0

-- 禁用 node provider（如果你不需要 node 插件）
-- vim.g.loaded_node_provider = 0

-- 禁用 perl provider
vim.g.loaded_perl_provider = 0

-- 禁用 ruby provider
vim.g.loaded_ruby_provider = 0
