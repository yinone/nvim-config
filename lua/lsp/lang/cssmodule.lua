return {
  cmd = { 'cssmodules-language-server' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  on_attach = function(client, bufnr)
  end,
  root_dir = function()
    return vim.fn.getcwd()
  end
}
