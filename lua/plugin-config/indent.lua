local status_ok, indent_blankline = pcall(require, 'indent_blankline')
if not status_ok then
  return
end

require('ibl').setup(

  {
    debounce = 100,
    indent = { char = '┊' },
    -- whitespace = { highlight = { 'CursorColumn', 'Whitespace' } },
    scope = { exclude = { language = { 'startify' } } },

    exclude = { filetypes = { 'startify' } }
  }
)
