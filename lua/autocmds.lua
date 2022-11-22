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

-- 进入Terminal 自动进入插入模式
autocmd('TermOpen', { group = myAutoGroup, command = 'startinsert' })

-- 修改lua/plugins.lua 自动更新插件
autocmd(
  { 'BufWritePost' }, {
    group = myAutoGroup,
    -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
    pattern = { '*/nvim/lua/plugins.lua' },
    callback = function(opts)
      vim.api.nvim_command('source ~/.config/nvim/lua/plugins.lua')
      vim.api.nvim_command('PackerSync')
    end
  }
)
