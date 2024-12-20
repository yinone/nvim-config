local status, nvim_tree = pcall(require, 'nvim-tree')
if not status then
  vim.notify('没有找到 nvim-tree')
  return
end

vim.cmd('highlight NvimTreeFolderIcon guifg=#8094b4')

local function my_on_attach(bufnr)

  local api = require('nvim-tree.api')
  local Event = api.events.Event

  local utils = require('utils.global')
  local uv = vim.loop

  local function opts(desc)
    return {
      desc = 'nvim-tree: ' .. desc,
      buffer = bufnr,
      noremap = true,
      silent = true,
      nowait = true
    }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'v', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', 'h', api.node.open.horizontal, opts('Open: Horizontal Split'))

  api.events.subscribe(
    Event.FileCreated, function(payload)

      local TEMPLATE;

      if not payload then
        return
      end

      local fd = uv.fs_open(vim.fn.expand(payload.fname), 'w+', 755)

      if string.match(payload.fname, '%.tsx$') then
        TEMPLATE = vim.fn.expand('~/.config/nvim/lua/snippets/react-component.tsx')
      end

      if TEMPLATE then
        utils.readFile(
          TEMPLATE, function(data)
            uv.fs_write(fd, data)
          end
        )
      end

    end
  )
end

nvim_tree.setup(
  {
    -- 显示 git 状态图标
    on_attach = my_on_attach,
    git = { enable = true },
    reload_on_bufenter = true,
    disable_netrw = true,
    hijack_netrw = false,
    hijack_cursor = true,
    -- project plugin 需要这样设置
    respect_buf_cwd = true,
    update_cwd = true,
    update_focused_file = { enable = true, update_cwd = false },
    -- 隐藏 .文件 和 node_modules 文件夹
    filters = { dotfiles = false, custom = { '.git', '.cache' }, exclude = { 'node_modules' } },
    view = {
      -- 宽度
      width = 30,
      -- 也可以 'right'
      side = 'left',
      -- 隐藏根目录
      -- hide_root_folder = false,
      -- 自定义列表中快捷键
      -- 不显示行数
      number = false,
      relativenumber = false,
      -- 显示图标
      signcolumn = 'yes'
    },
    actions = { open_file = { resize_window = true } },
    notify = { threshold = vim.log.levels.BEBUG }
  }
)
