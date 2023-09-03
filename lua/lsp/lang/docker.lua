return {
  cmd = { 'docker-langserver', '--stdio' },
  filetypes = { 'dockerfile' },
  on_attach = function(client, bufnr)
    require('nvim-navic').attach(client, bufnr)
  end,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true
}
