local status, telescope = pcall(require, 'telescope')
if not status then
  vim.notify('没有找到 telescope', 'error')
  return
end
-- telescope-config.lua
local M = {}

telescope.setup(
  {
    defaults = {
      -- winblend = 40,
      -- 打开弹窗后进入的初始模式，默认为 insert，也可以是 normal
      initial_mode = 'insert',
      layout_config = { vertical = { width = 0.95 } }
    },
    pickers = {
      -- 内置 pickers 配置
      find_files = {
        -- 查找文件换皮肤，支持的参数有： dropdown, cursor, ivy
        -- theme = "dropdown", 
      }
    },
    extensions = {
      -- 扩展插件配置
      file_browser = {
        -- use the "ivy" theme if you want
        cwd_to_path = true
      },
      media_files = {
        -- filetypes whitelist
        -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
        filetypes = { 'png', 'webp', 'jpg', 'jpeg' },
        find_cmd = 'rg' -- find command (defaults to `fd`)
      }
    }
  }
)

-- 插件加载
telescope.load_extension('fzf')
telescope.load_extension('file_browser')

M.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then
    require'telescope.builtin'.find_files(opts)
  end
end

return M
