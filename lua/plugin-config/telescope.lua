local M = {}

M.project_files = function()
  local builtin = require("telescope.builtin")
  local opts = {}
  local ok = pcall(builtin.git_files, opts)
  if not ok then
    builtin.find_files(opts)
  end
end

return M
