local lspconfig = require('lspconfig')

return {
  cmd = { "zk", "lsp" },
  filetypes = { "markdown" },
  root_dir = function()
    return vim.fn.getcwd()
  end,
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    require("keybindings").mapLSP(buf_set_keymap)
  end,
}
