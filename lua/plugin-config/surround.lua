local status, surround = pcall(require, 'surround')
if not status then
  vim.notify('没有找到 surround', 'error')
  return
end

surround.setup({ mappings_style = 'surround' })
