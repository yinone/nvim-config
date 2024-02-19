local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system(
    {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath
    }
  )
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
  {

    -- start screen
    'mhinz/vim-startify',

    -- tokyonight
    { 'folke/tokyonight.nvim' },

    -- git commit author
    'rhysd/conflict-marker.vim',

    -- filetype
    'nathom/filetype.nvim',

    --- typescript comment
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      config = function()
        require('ts_context_commentstring').setup {}
      end
    },

    {
      'nvim-treesitter/nvim-treesitter-textobjects',
      after = 'nvim-treesitter',
      requires = 'nvim-treesitter/nvim-treesitter'
    },

    -- git diff 
    { 'sindrets/diffview.nvim', dependencies = 'nvim-lua/plenary.nvim' },

    ------ tmux navigator
    -- 'christoomey/vim-tmux-navigator',

    -- nvim-tree
    {
      'nvim-tree/nvim-tree.lua',
      dependencies = 'nvim-tree/nvim-web-devicons',
      tag = 'nightly',
      config = function()
        require('plugin-config.nvim-tree')
      end
    },

    -- bufferline
    {
      'akinsho/bufferline.nvim',
      version = 'v3.*',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('plugin-config.bufferline')
      end
    },

    -- buffer delete
    'moll/vim-bbye',

    -- telescope
    {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.4',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('plugin-config.telescope')
      end
    },

    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },

    -- gps
    { 'SmiteshP/nvim-navic' },

    -- statusline
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { { 'nvim-tree/nvim-web-devicons', lazy = true } },
      config = function()
        require('plugin-config.statusline')
      end
    },

    -- gitsigns
    {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup({ current_line_blame = true })
      end
    },

    -- indent-blankline
    {
      'lukas-reineke/indent-blankline.nvim',
      config = function()
        require('plugin-config.indent')
      end
    },

    -- nvim-treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      config = function()
        require('plugin-config.treesitter')
      end
    },

    -- nvim-autopairs
    {
      'windwp/nvim-autopairs',
      config = function()
        require('plugin-config.autopairs')
      end
    },

    -- auto-close-tag
    {
      'windwp/nvim-ts-autotag',
      config = function()
        require('nvim-ts-autotag').setup()
      end
    },

    { 'jose-elias-alvarez/null-ls.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },

    {
      'glepnir/lspsaga.nvim',
      branch = 'main',
      config = function()
        require('plugin-config.lspsaga')
      end
    },

    -- waketime
    'wakatime/vim-wakatime',

    --- lsp config
    { 'williamboman/mason.nvim' },
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    -- cmp
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',

    -- snip
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    -- lspkind
    'onsails/lspkind-nvim',

    

    -- comment
    'tpope/vim-commentary',

    -- JSON 增强
    'b0o/schemastore.nvim',

    -- nvim-colorizer
    {
      'norcalli/nvim-colorizer.lua',
      config = function()
        require('colorizer').setup()
      end
    },

    {
      'kylechui/nvim-surround',
      event = 'VeryLazy',
      config = function()
        require('nvim-surround').setup(
          {
            -- Configuration here, or leave empty to use defaults
          }
        )
      end
    },

    {
      'NeogitOrg/neogit',
      dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'sindrets/diffview.nvim', -- optional - Diff integration

        -- Only one of these is needed, not both.
        'nvim-telescope/telescope.nvim', -- optional
        'ibhagwan/fzf-lua' -- optional
      },
      config = true
    }

  }, {
    defaults = { lazy = false },
    install = { colorscheme = { 'tokyonight' } },
    checker = { enabled = true },
    change_detection = { notify = false },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin'
        }
      }
    }
  }
)
