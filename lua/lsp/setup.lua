local lsp_installer = require('nvim-lsp-installer')
local capabilities = require('cmp_nvim_lsp').default_capabilities(
                       vim.lsp.protocol.make_client_capabilities()
                     )
local lspconfig = require('lspconfig')
-- 安装列表
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
-- { key: 语言 value: 配置文件 }
lsp_installer.setup {}

local servers = {

  sumneko_lua = require('lsp.lang.lua'),
  bashls = require('lsp.lang.bash'),
  tsserver = require('lsp.lang.ts'),
  html = require('lsp.lang.html'),
  cssls = require('lsp.lang.css'),
  gopls = require('lsp.lang.golang'),
  jsonls = require('lsp.lang.json'),
  vuels = require('lsp.lang.vue'),
  cssmodules_ls = require('lsp.lang.cssmodule'),
  vimls = require('lsp.lang.vim'),
  dockerls = require('lsp.lang.docker')

}

-- 自动安装 LanguageServers
for name, _ in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)

  if server_is_found then
    if not server:is_installed() then
      print('Installing ' .. name)
      server:install()
    end

    local config = servers[server.name]

    if config == nil then
      return
    end

    config.capabilities = capabilities;
    lspconfig[server.name].setup(config)

  end
end
