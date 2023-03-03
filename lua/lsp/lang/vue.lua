return {
  cmd = { 'vls' },
  filetypes = { 'vue' },
  init_options = {
    config = {
      css = {},
      emmet = {},
      html = { suggest = {} },
      javascript = { format = {} },
      stylusSupremacy = {},
      typescript = { format = {} },
      vetur = {
        completion = { autoImport = false, tagCasing = 'kebab', useScaffoldSnippets = false },
        format = {
          defaultFormatter = { js = 'none', ts = 'none' },
          defaultFormatterOptions = {},
          scriptInitialIndent = false,
          styleInitialIndent = false
        },
        useWorkspaceDependencies = false,
        validation = { script = true, style = true, template = true }
      }
    }
  },
  root_dir = function()
    return vim.fn.getcwd()
  end,
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    require('keybindings').mapLSP(buf_set_keymap)
  end
}
