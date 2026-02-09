return {
  cmd = { os.getenv("HOME") .. "/golang/bin/gopls" },
  filetypes = { 'go', 'gomod', 'gotmpl', "gowork", },
  root_dir = function()
    return vim.fn.getcwd()
  end,
  single_file_support = true,
  -- 性能优化配置
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      -- 减少内存占用
      build = {
        allowModfileModifications = false,
        allowNetwork = false,
      },
      ui = {
        diagnostic = {
          annotations = {
            bounds = false,
            escape = false,
            inline = false,
          },
        },
      },
    },
  },
}
