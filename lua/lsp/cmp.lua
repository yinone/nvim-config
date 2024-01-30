local lspkind = require('lspkind')
local cmp = require('cmp')
local snip = require('luasnip')
local s = snip.snippet
local t = snip.text_node
local i = snip.insert_node

snip.add_snippets('all', { s('/', { t({ '/**' }), i(1), t({ '*/' }) }) })

cmp.setup(
  {
    formatting = {
      format = lspkind.cmp_format(
        {
          mode = 'symbol_text',
          maxwidth = 50,
          before = function(entry, vim_item)
            vim_item.menu = '[' .. string.upper(entry.source.name) .. ']'
            return vim_item
          end
        }
      )
    },

    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        snip.lsp_expand(args.body)
      end
    },
    -- 来源
    sources = cmp.config.sources(
      { { name = 'nvim_lsp' }, { name = 'buffer' }, { name = 'luasnip' } }, { { name = 'path' } }
    ),

    -- 快捷键
    mapping = require('keybindings').cmp(cmp)
    -- 使用lspkind-nvim显示类型图标
    -- formatting = require("lsp.ui").formatting,
  }
)
-- Use buffer source for `/`.
cmp.setup
  .cmdline('/', { mapping = cmp.mapping.preset.cmdline(), sources = { { name = 'buffer' } } })

-- Use cmdline & path source for ':'.
cmp.setup.cmdline(
  ':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({ { name = 'path' } }, { { name = 'cmdline' } })
  }
)
