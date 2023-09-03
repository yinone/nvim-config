local status, lspsaga = pcall(require, 'lspsaga')
if not status then
  vim.notify('没有找到lspsaga')
  return
end

lspsaga.setup({ symbol_in_winbar = { enable = false }, theme = 'tokyonight' })
