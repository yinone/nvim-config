local status, null_ls = pcall(require, 'null-ls')
if not status then
  vim.notify('没有找到 null-ls', 'error')
  return
end

local formatting = null_ls.builtins.formatting

null_ls.setup(
  {
    debug = false,
    sources = {
      -- Formatting ---------------------
      formatting.prettier_d_slim,
      formatting.fixjson,
      formatting.lua_format.with(
        { extra_args = { '-c', vim.fn.expand('~/.config/nvim/lua/linter-config/.lua-format.yml') } }
      )
    },

    on_attach = function(client)
      if client.server_capabilities.documentFormattingProvider then
        vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.format{async = false}')
      end

    end
  }
)
