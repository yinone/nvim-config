local status, null_ls = pcall(require, 'null-ls')
if not status then
  vim.notify('没有找到 null-ls', 'error')
  return
end

local formatting = null_ls.builtins.formatting
local code_action = null_ls.builtins.code_actions

null_ls.setup(
  {
    debug = false,
    sources = {

      -- Formatting ---------------------
      formatting.prettierd.with(
        {
          filetypes = {
            'javascript',
            'javascriptreact',
            'typescript',
            'typescriptreact',
            'vue',
            'css',
            'scss',
            'less',
            'html',
            'json',
            'jsonc',
            'yaml',
            'markdown',
            'markdown.mdx',
            'graphql',
            'handlebars',
            'svelte'
          }

        }
      ),
      -- code_action.eslint,
      formatting.fixjson,
      formatting.lua_format.with(
        { extra_args = { '-c', vim.fn.expand('~/.config/nvim/lua/linter-config/.lua-format.yml') } }
      )
    },

    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd('autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ timeout_ms = 2000 })')
      end
    end
  }
)
