local lspconfig = require('lspconfig')

return {
  cmd = { "docker-langserver", "--stdio" },
  filetypes = { "dockerfile" },
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
}
