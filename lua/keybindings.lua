-- 全局快捷键设置
-- vim.api.nvim_set_keymap('模式'，'按键', '映射为', 'options')
-- Buffer快捷键设置
-- vim.api.nvim_buf_set_keymap('模式', '按键', '映射为', 'options')
--[[ in Normal 模式 ]]
--[[ i Insert 模式 ]]
--[[ v Visual 模式 ]]
--[[ t Terminal 模式 ]]
--[[ c Command 模式 ]]
-- Prefixer leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap
local opt = { noremap = true, silent = true }

-- windows 分屏快捷键
map("n", "sv", ":vsp<CR>", opt)
map("n", "sh", ":sp<CR>", opt)
map("n", "<Left>", ":vertical resize +1<CR>", opt)
map("n", "<Right>", ":vertical resize -1<CR>", opt)
map("n", "<Up>", ":resize -1<CR>", opt)
map("n", "<Down>", ":resize +1<CR>", opt)

-- 关闭当前
map("n", "sc", "<C-w>c", opt)
-- 关闭其他
map("n", "so", "<C-w>o", opt)
-- Alt + hjkl  窗口之间跳转
map("n", "<leader>h", "<C-w>h", opt)
map("n", "<leader>j", "<C-w>j", opt)
map("n", "<leader>k", "<C-w>k", opt)
map("n", "<leader>l", "<C-w>l", opt)

-- visual模式下缩进代码
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)


-- 上下移动选中文本
map("v", "J", ":move '>+1<CR>gv-gv", opt)
map("v", "K", ":move '<-2<CR>gv-gv", opt)

-- 半屏滚动后居中光标，避免视线跳动
map("n", "<C-u>", "<C-u>zz", opt)
map("n", "<C-d>", "<C-d>zz", opt)

-- 全选
map("n", "<leader>uu", ":Lazy sync<CR>", opt)
map("n", "<leader>a", "gg<S-v>G", opt)
-- 退出
map("i", "jj", "<ESC>", opt)
map("n", "<leader>q", ":q<CR>", opt)
map("n", "<leader>qq", ":qa<CR>", opt)
map("n", "<leader>w", ":w<CR>", opt)
map("n", "<leader>wa", ":wa<CR>", opt)
map("i", "<C-s>", "<cmd>w<CR>", opt)
map("n", "<C-s>", "<cmd>w<CR>", opt)
map("n", "<leader>x", ":x<CR>", opt)
map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", opt)
map("n", "<leader>r", ":%s///g<Left><Left><Left>", opt)
-- 插件快捷键
local pluginKeys = {}
------------------------- nvim-tree --------------------------------
map("n", "<leader>n", ":NvimTreeToggle<CR>", opt)

------------------------ git -----------------------------
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_insert_modes = 0
map("n", "<leader>do", ":DiffviewOpen<CR>", opt)
map("n", "<leader>dc", ":tabclose<CR>", opt)
map("n", "<leader>dh", ":DiffviewFileHistory<CR>", opt)
------------------- vsnip ---------------------
vim.g.vsnip_snippet_dir = vim.fn.expand("~/.config/nvim/lua/snippets")

-------------------------- Bufferline ------------------------------
-- 左右Tab切换
map("n", "<leader>f", ":BufferLineCycleNext<CR>", opt)
map("n", "<leader>d", ":BufferLineCyclePrev<CR>", opt)
-- 关闭
-- "moll/vim-bbye"
map("n", "<leader>bd", ":Bdelete!<CR>", opt)
map("n", "<leader>bb", ":b#<CR>", opt)

--------------------------  Telescope -------------------------------
-- 查找文件
map("n", "<leader>ff", "<CMD>lua require'plugin-config.telescope'.project_files()<CR>", opt)
-- 全局搜索
map("n", "<leader>fg", ":Telescope live_grep<CR>", opt)
-- buffers
map("n", "<leader>fb", ":Telescope buffers<CR>", opt)
-- helps
map("n", "<leader>fh", ":Telescope help_tags<CR>", opt)
-- 兼容旧快捷键
map("n", "<C-p>", ":Telescope find_files<CR>", opt)
map("n", "<C-g>", ":Telescope live_grep<CR>", opt)
map("n", "<leader>b", ":Telescope buffers<CR>", opt)
-- git
map("n", "<leader>gc", ":Telescope git_commits<CR>", opt)
map("n", "<leader>gb", ":Telescope git_branches<CR>", opt)
map("n", "<leader>gu", ":Telescope git_status<CR>", opt)

--------------------------------- lsp 回调函数快捷键设置 -----------------------
pluginKeys.mapLSP = function(mapbuf)
	mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
	mapbuf("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opt)
	mapbuf("n", "gr", "<cmd>Lspsaga finder<CR>", opt)
	mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
	mapbuf("n", "ge", "<cmd>lua require'telescope.builtin'.diagnostics()<CR>", opt)
	mapbuf("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
	mapbuf("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
	mapbuf("n", "gs", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
	mapbuf("n", "gn", "<cmd>Lspsaga rename<CR>", opt)
	mapbuf("n", "gp", "<cmd>Lspsaga peek_definition<CR>", opt)
	mapbuf("n", "ot", "<cmd>Lspsaga outline<CR>", opt)
end

-- toggle term
map("n", "<leader>tt", "<cmd>:split term://zsh<CR>", opt)

-- typescript 快捷键（原生 LSP 实现，替代已弃用的 nvim-lsp-ts-utils）
local function ts_code_action(kind)
	vim.lsp.buf.code_action({ context = { only = { kind } }, apply = true })
end

local function ts_rename_file()
	local old = vim.api.nvim_buf_get_name(0)
	local new = vim.fn.input("New path: ", old)
	if new == "" or new == old then return end
	local params = { files = { { oldUri = vim.uri_from_fname(old), newUri = vim.uri_from_fname(new) } } }
	local resp = vim.lsp.buf_request_sync(0, "workspace/willRenameFiles", params, 2000)
	if resp then
		for _, res in pairs(resp) do
			if res.result then vim.lsp.util.apply_workspace_edit(res.result, "utf-8") end
		end
	end
	vim.fn.rename(old, new)
	vim.cmd("edit " .. vim.fn.fnameescape(new))
	vim.cmd("bdelete " .. vim.fn.bufnr(old))
end

pluginKeys.mapTsLSP = function(mapbuf)
	mapbuf("n", "ts", "", vim.tbl_extend("force", opt, { callback = function() ts_code_action("source.organizeImports") end }))
	mapbuf("n", "tr", "", vim.tbl_extend("force", opt, { callback = ts_rename_file }))
	mapbuf("n", "ti", "", vim.tbl_extend("force", opt, { callback = function() ts_code_action("source.addMissingImports") end }))
end

-- 补全键位由 blink.cmp 自己管理（见 lsp/cmp.lua）

return pluginKeys
