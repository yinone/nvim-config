return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gotmpl', "gowork", },
  root_dir = function()
    return vim.fn.getcwd()
  end,
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    require('keybindings').mapLSP(buf_set_keymap)
    require('nvim-navic').attach(client, bufnr)
  end,
  single_file_support = true
}
