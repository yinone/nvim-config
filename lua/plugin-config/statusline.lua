local status, lualine = pcall(require, 'lualine')
if not status then
  vim.notify('没有找到 lualine', 'error')
  return
end

local gps = require('nvim-gps')

lualine.setup(
  {
    options = {
      -- 指定皮肤
      -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      theme = 'horizon',
      -- 分割线
      component_separators = { left = '|', right = '|' }
      -- https://github.com/ryanoasis/powerline-extra-symbols
      -- section_separators = {
      --     left = " ",
      --     right = ""
      -- }
    },
    extensions = { 'nvim-tree' },
    sections = {
      lualine_c = {
        'filename',
        { gps.get_location, cond = gps.is_available }
        -- { 'lsp_progress', spinner_symbols = { ' ', ' ', ' ', ' ', ' ', ' ' } }
      },
      lualine_x = { 'filesize', 'encoding', 'filetype' }
    }
  }
)
