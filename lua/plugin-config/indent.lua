local status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not status_ok then
  return
end

vim.wo.colorcolumn = '99999'

require('ibl').setup(

  {
    debounce = 100,
    indent = { char = '┊' },
    scope = { enabled = false },
    exclude = { filetypes = { 'startify' } }
  }
)
