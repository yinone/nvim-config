-- LuaSnip 自定义片段（blink.cmp 的 setup 由 lazy.nvim 在 plugins.lua 中触发）
local ok_snip, snip = pcall(require, "luasnip")
if ok_snip then
  local s = snip.snippet
  local t = snip.text_node
  local i = snip.insert_node
  snip.add_snippets("all", { s("/", { t({ "/**" }), i(1), t({ "*/" }) }) })
end
