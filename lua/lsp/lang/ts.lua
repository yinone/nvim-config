local keybindings = require('keybindings')
local ts_utils = require('nvim-lsp-ts-utils')

return {
  flags = { debounce_text_changes = 150 },

  -- settings = {
  --   typescript = {
  --     inlayHints = {
  --       includeInlayParameterNameHints = 'all',
  --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --       includeInlayFunctionParameterTypeHints = true,
  --       includeInlayVariableTypeHints = true,
  --       includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  --       includeInlayPropertyDeclarationTypeHints = true,
  --       includeInlayFunctionLikeReturnTypeHints = true,
  --       includeInlayEnumMemberValueHints = true
  --     }
  --   },
  --   javascript = {
  --     inlayHints = {
  --       includeInlayParameterNameHints = 'all',
  --       includeInlayParameterNameHintsWhenArgumentMatchesName = true,
  --       includeInlayFunctionParameterTypeHints = true,
  --       includeInlayVariableTypeHints = true,
  --       includeInlayVariableTypeHintsWhenTypeMatchesName = true,
  --       includeInlayPropertyDeclarationTypeHints = true,
  --       includeInlayFunctionLikeReturnTypeHints = true,
  --       includeInlayEnumMemberValueHints = true
  --     }
  --   }
  -- },

  on_attach = function(client, bufnr)

    vim.lsp.inlay_hint.enable(true)

    -- 禁用格式化功能，交给专门插件插件处理
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false

    require('nvim-navic').attach(client, bufnr)

    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    -- 绑定快捷键
    keybindings.mapLSP(buf_set_keymap)
    -- defaults
    ts_utils.setup(
      {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = false,
        -- import all
        import_all_timeout = 5000, -- ms
        -- lower numbers = higher priority
        import_all_priorities = {
          same_file = 1, -- add to existing import statement
          local_files = 2, -- git files or files with relative path markers
          buffer_content = 3, -- loaded buffer content
          buffers = 4 -- loaded buffer names
        },
        import_all_scan_buffers = 100,
        import_all_select_source = false,
        -- if false will avoid organizing imports
        always_organize_imports = true,

        -- filter diagnostics
        filter_out_diagnostics_by_severity = {},
        -- https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        filter_out_diagnostics_by_code = { 80001 },

        -- inlay hints
        auto_inlay_hints = true,
        inlay_hints_highlight = 'Comment',
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
        inlay_hints_format = { -- format options for individual hint kind
          Type = {},
          Parameter = {},
          Enum = {}
        },

        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil
      }
    )
    -- required to fix code action ranges and filter diagnostics
    ts_utils.setup_client(client)
    -- no default maps, so you may want to define some here
    keybindings.mapTsLSP(buf_set_keymap)
  end
}
