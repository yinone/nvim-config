local keybindings = require('keybindings')

return {
  flags = { debounce_text_changes = 150 },
  on_attach = function(client, bufnr)

    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    require('nvim-navic').attach(client, bufnr)

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    keybindings.mapLSP(buf_set_keymap) 

  end,
  
}
