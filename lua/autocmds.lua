local myAutoGroup = vim.api.nvim_create_augroup('myAutoGroup', { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- filetype with init template
autocmd(
  { 'BufNewFile' }, {
    group = myAutoGroup,
    pattern = { '*.tsx' },
    callback = function()
      vim.api.nvim_command('0r ~/.config/nvim/lua/snippets/react-component.tsx')
      vim.api.nvim_command('set filetype=javascriptreact')
    end
  }
)
