return {
  -- flags = { debounce_text_changes = 150 },
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    require('keybindings').mapLSP(buf_set_keymap)
    require('nvim-navic').attach(client, bufnr)

  end
}
