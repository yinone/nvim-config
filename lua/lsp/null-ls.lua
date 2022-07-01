local status, null_ls = pcall(require, 'null-ls')
if not status then
  vim.notify('没有找到 null-ls')
  return
end

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

null_ls.setup(
  {
    debug = true,
    sources = {
      -- Formatting ---------------------
      -- frontend
      formatting.prettierd.with(
        { -- 比默认少了 markdown
          prefer_local = 'node_modules/.bin',
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
            'jsonc',
            'yaml',
            'markdown',
            'graphql',
            'handlebars'
          },
          env = {
            string.format(
              'PRETTIERD_DEFAULT_CONFIG=%s',
                vim.fn.expand('~/.config/nvim/lua/linter-config/.prettierrc.json')
            )
          }
        }
      ),
      formatting.fixjson.with {},
      formatting.lua_format.with(
        { extra_args = { '-c', vim.fn.expand('~/.config/nvim/lua/linter-config/.lua-format.yml') } }
      ),
      code_actions.gitsigns
    },

    -- #{m}: message
    -- #{s}: source name (defaults to null-ls if not specified)
    -- #{c}: code (if available)
    -- 提示格式： [eslint] xxx
    -- diagnostics_format = "[#{s}] #{m}",
    on_attach = function(client)
      if client.resolved_capabilities.document_formatting then
        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
      end

    end
  }
)
