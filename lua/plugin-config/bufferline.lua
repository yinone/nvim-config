local status, bufferline = pcall(require, 'bufferline')
if not status then
  vim.notify('没有找到 bufferline', 'error')
  return
end

-- bufferline 配置
bufferline.setup(
  {
    options = {
      -- 关闭 Tab 的命令，这里使用 moll/vim-bbye 的 :Bdelete 命令
      close_command = 'Bdelete! %d',
      right_mouse_command = 'Bdelete! %d',
      numbers = 'both', -- 侧边栏配置
      sort_by = 'insert_after_current',
      show_tab_indicators = true,

      -- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
      offsets = {
        {
          filetype = 'NvimTree',
          text = 'One Code Always',
          highlight = 'Directory',
          text_align = 'left'
        }
      },
      show_buffer_close_icons = false,
      separator_style = { '', '' },
      indicator = { icon = '', style = 'underline' },
      highlights = { separator_selected = { fg = '', bg = '#33333' } }
    }
  }
)
