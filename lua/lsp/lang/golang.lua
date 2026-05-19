return {
  -- 交给 Mason 注入后的 PATH 解析，避免写死本地路径。
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gotmpl", "gowork" },
  root_dir = function(bufnr, on_dir)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    on_dir(vim.fs.root(fname, { "go.work", "go.mod", ".git" }) or vim.fs.dirname(fname))
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
    },
  },
}
