-- 全局快捷键设置
-- vim.api.nvim_set_keymap('模式'，'按键', '映射为', 'options')
-- Buffer快捷键设置
-- vim.api.nvim_buf_set_keymap('模式', '按键', '映射为', 'options')
--[[ in Normal 模式 ]] --[[ i Insert 模式 ]] --[[ v Visual 模式 ]] --[[ t Terminal 模式 ]] --[[ c Command 模式 ]] -- Prefixer leader mapping
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.api.nvim_set_keymap
local buf_map = vim.api.nvim_buf_set_keymap
local opt = { noremap = true, silent = true }

-- windows 分屏快捷键
map('n', 'sv', ':vsp<CR>', opt)
map('n', 'sh', ':sp<CR>', opt)
map('n', '<Left>', ':vertical resize +1<CR>', opt)
map('n', '<Right>', ':vertical resize -1<CR>', opt)
map('n', '<Up>', ':resize -1<CR>', opt)
map('n', '<Down>', ':resize +1<CR>', opt)

-- 关闭当前
map('n', 'sc', '<C-w>c', opt)
-- 关闭其他
map('n', 'so', '<C-w>o', opt)
-- Alt + hjkl  窗口之间跳转
map('n', '<leader>h', '<C-w>h', opt)
map('n', '<leader>j', '<C-w>j', opt)
map('n', '<leader>k', '<C-w>k', opt)
map('n', '<leader>l', '<C-w>l', opt)

-- visual模式下缩进代码
map('v', '<', '<gv', opt)
map('v', '>', '>gv', opt)

-- 代码折叠
map('n', 'z', 'za', opt)

-- 上下移动选中文本
map('v', 'J', ':move \'>+1<CR>gv-gv', opt)
map('v', 'K', ':move \'<-2<CR>gv-gv', opt)

-- 上下滚动浏览
map('n', '<C-j>', '4j', opt)
map('n', '<C-k>', '4k', opt)
-- ctrl u / ctrl + d  只移动9行，默认移动半屏
map('n', '<C-u>', '9k', opt)
map('n', '<C-d>', '9j', opt)

-- 全选
map('n', '<leader>uu', ':Lazy sync<CR>', opt)
map('n', '<leader>a', 'gg<S-v>G', opt)
-- 退出
map('i', 'jj', '<ESC>', opt)
map('n', '<leader>q', ':q<CR>', opt)
map('n', '<leader>qq', ':qa<CR>', opt)
map('n', '<leader>w', ':w!<CR>', opt)
map('n', '<leader>wa', ':wa<CR>', opt)
map('i', '<C-s>', '<ESC>:w!<CR>', opt)
map('n', '<C-s>', '<ESC>:w!<CR>', opt)
map('n', '<leader>x', ':x<CR>', opt)
map('n', '<ESC>', ':nohlsearch<Bar>:echo<CR>', opt)
map('n', '<leader>r', ':%s///g<Left><Left><Left>', opt)
-- 插件快捷键
local pluginKeys = {}
------------------------- nvim-tree --------------------------------
map('n', '<leader>n', ':NvimTreeToggle<CR>', opt)

------------------------ git -----------------------------
vim.g.blamer_enabled = 1
vim.g.blamer_show_in_insert_modes = 0
map('n', '<leader>do', ':DiffviewOpen<CR>', opt)
map('n', '<leader>dc', ':tabclose<CR>', opt)
map('n', '<leader>dh', ':DiffviewFileHistory<CR>', opt)
------------------- vsnip ---------------------
vim.g.vsnip_snippet_dir = vim.fn.expand('~/.config/nvim/lua/snippets')

-------------------------- Bufferline ------------------------------
-- 左右Tab切换
map('n', '<leader>f', ':BufferLineCycleNext<CR>', opt)
map('n', '<leader>d', ':BufferLineCyclePrev<CR>', opt)
-- 关闭
-- "moll/vim-bbye"
map('n', '<leader>bd', ':Bdelete!<CR>', opt)
map('n', '<leader>bb', ':b#<CR>', opt)

--------------------------  Telescope -------------------------------
-- 查找文件
map('n', '<leader>ff', '<CMD>lua require\'plugin-config.telescope\'.project_files()<CR>', opt)
-- 全局搜索
map('n', '<leader>fg', ':Telescope live_grep<CR>', opt)
-- buffers
map('n', '<leader>fb', ':Telescope buffers<CR>', opt)
-- helps
map('n', '<leader>fh', ':Telescope help_tags<CR>', opt)
-- registers
map('n', '<leader>fr', ':Telescope neoclip<CR>', opt)
-- tags
map('n', '<leader>ag', ':Telescope tags<CR>', opt)
map('n', '<leader>git', ':Neogit<CR>', opt)
-- git
map('n', '<leader>gc', ':Telescope git_commits<CR>', opt)
map('n', '<leader>gb', ':Telescope git_branches<CR>', opt)
map('n', '<leader>gu', ':Telescope git_status<CR>', opt)

--------------------------------- lsp 回调函数快捷键设置 -----------------------
pluginKeys.mapLSP = function(mapbuf)
  mapbuf('n', '<leader>ca', '<cmd>Lspsaga code_action<CR>', opt)
  mapbuf('n', 'gd', '<cmd>Lspsaga goto_definition<CR>', opt)
  mapbuf('n', 'gr', '<cmd>Lspsaga finder<CR>', opt)
  mapbuf('n', 'gh', '<cmd>Lspsaga hover_doc<cr>', opt)
  mapbuf('n', 'ge', '<cmd>lua require\'telescope.builtin\'.diagnostics()<CR>', opt)
  mapbuf('n', '[e', '<cmd>Lspsaga diagnostic_jump_next<cr>', opt)
  mapbuf('n', ']e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', opt)
  mapbuf('n', 'gs', '<cmd>Lspsaga show_line_diagnostics<CR>', opt)
  mapbuf('n', 'gn', '<cmd>Lspsaga rename<CR>', opt)
  mapbuf('n', 'gp', '<cmd>Lspsaga peek_definition<CR>', opt)
  mapbuf('n', 'ot', '<cmd>Lspsaga outline<CR>', opt)
end

-- toggle term
map('n', '<leader>tt', '<cmd>:split term://zsh<CR>', opt)

-- typescript 快捷键
pluginKeys.mapTsLSP = function(mapbuf)
  mapbuf('n', 'ts', ':TSLspOrganize<CR>', opt)
  mapbuf('n', 'tr', ':TSLspRenameFile<CR>', opt)
  mapbuf('n', 'ti', ':TSLspImportAll<CR>', opt)
end

-- nvim-cmp 自动补全
pluginKeys.cmp = function(cmp)
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
             vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  return {
    -- super Tab
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { 'i', 's' }
    ),

    ['<S-Tab>'] = cmp.mapping(
      function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, { 'i', 's' }
    )
    -- end of super Tab
  }
end

return pluginKeys
