local lspconfig = require('lspconfig')

return {
  cmd = { 'vim-language-server', '--stdio' },
  filetypes = { 'vim' },
  init_options = {
    diagnostic = { enable = true },
    indexes = {
      count = 3,
      gap = 100,
      projectRootPatterns = { 'runtime', 'nvim', '.git', 'autoload', 'plugin' },
      runtimepath = true
    },
    iskeyword = '@,48-57,_,192-255,-#',
    runtimepath = '',
    suggest = { fromRuntimepath = true, fromVimruntime = true },
    vimruntime = ''
  },
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require('keybindings').mapLSP(buf_set_keymap)
  end,
  root_dir = function(fname)
    return lspconfig.util.find_git_ancestor(fname) or vim.fn.getcwd()
  end
}
