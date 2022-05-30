local status, neoclip = pcall(require, "neoclip")
if not status then
  vim.notify("没有找到 neoclip")
  return
end

neoclip.setup({
  enable_persistent_history = true,
  on_paste = {
    set_reg = true
  },
  default_register = { '"', '+', '*' }
})
