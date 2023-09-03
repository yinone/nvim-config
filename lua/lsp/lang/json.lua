return {
  settings = { json = { schemas = require('schemastore').json.schemas() } },
  flags = { debounce_text_changes = 150 },
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require('nvim-navic').attach(client, bufnr)
    require('keybindings').mapLSP(buf_set_keymap)
  end
}
