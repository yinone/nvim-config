local lsp_installer = require("nvim-lsp-installer")
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: 语言 value: 配置文件 }

local servers = {

  bashls = require("lsp.lang.bash"),
  tsserver = require("lsp.lang.ts"),
  html = require("lsp.lang.html"),
  cssls = require("lsp.lang.css"),
  gopls = require("lsp.lang.golang"),
  jsonls = require("lsp.lang.json"),
  vuels = require("lsp.lang.vue"),
  cssmodules_ls = require("lsp.lang.cssmodule"),
  vimls = require("lsp.lang.vim"),
  dockerls = require("lsp.lang.docker"),

}

-- 自动安装 LanguageServers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

lsp_installer.on_server_ready(function(server)
  local config = servers[server.name]

  if config == nil then
    return
  end

  config.capabilities = capabilities;
  server:setup(config)

end)
