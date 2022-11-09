local status, noice = pcall(require, 'noice')
if not status then
  vim.notify('没有找到 neoice')
  return
end

noice.setup({ messages = { enabled = false } })
