-- :h mason-default-settings
require('mason').setup(
  {
    ui = {
      icons = { package_installed = '✓', package_pending = '➜', package_uninstalled = '✗' }
    }
  }
)

require('mason-lspconfig').setup(
  {
    ensure_installed = {
      'lua_ls',
      'tsserver',
      'bashls',
      'cssls',
      'html',
      'jsonls',
      'gopls',
      'vuels',
      'vimls',
      'cssmodules_ls',
      'dockerls',
      'svelte'
    }
  }
)

local capabilities = require('cmp_nvim_lsp').default_capabilities(
                       vim.lsp.protocol.make_client_capabilities()
                     )

local lspconfig = require('lspconfig')

local servers = {
  lua_ls = require('lsp.lang.lua'),
  bashls = require('lsp.lang.bash'),
  tsserver = require('lsp.lang.ts'),
  html = require('lsp.lang.html'),
  cssls = require('lsp.lang.css'),
  gopls = require('lsp.lang.golang'),
  jsonls = require('lsp.lang.json'),
  vuels = require('lsp.lang.vue'),
  cssmodules_ls = require('lsp.lang.cssmodule'),
  vimls = require('lsp.lang.vim'),
  dockerls = require('lsp.lang.docker'),
  svelte = require('lsp.lang.svelte')
}

-- 自动安装 LanguageServers
for name, _ in pairs(servers) do
  local config = servers[name]

  if config == nil then
    return
  end

  config.capabilities = capabilities;

  lspconfig[name].setup(config)

end
