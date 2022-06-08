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

-- 保存时自动格式化
autocmd(
  'BufWritePre', {
    group = myAutoGroup,
    pattern = { '*.ts', '*.js', '*.html', '*.tsx', '*.vue', '*.scss', '*.less', '*.css', '*.lua' },
    callback = vim.lsp.buf.formatting_sync
  }
)

-- 修改lua/plugins.lua 自动更新插件
autocmd(
  { 'BufWritePost' }, {
    group = myAutoGroup,
    -- autocmd BufWritePost plugins.lua source <afile> | PackerSync
    callback = function()
      if vim.fn.expand('<afile>') == 'plugins.lua' then
        vim.api.nvim_command('source plugins.lua')
        vim.api.nvim_command('PackerSync')
      end
    end
  }
)
