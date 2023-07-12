local status, noice = pcall(require, 'noice')
if not status then
  vim.notify('没有找到 neoice', 'error')
  return
end

noice.setup(
  {
    messages = { enabled = false },
    notify = { enabled = false },
    lsp = { progress = { enable = false }, message = { enable = false } }
  }
)
