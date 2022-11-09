local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local paccker_bootstrap
if fn.empty(fn.glob(install_path)) > 0 then
  vim.notify('正在安装Pakcer.nvim，请稍后...')
  paccker_bootstrap = fn.system(
                        {
      'git',
      'clone',
      '--depth',
      '1', -- "https://github.com/wbthomason/packer.nvim",
      'https://gitcode.net/mirrors/wbthomason/packer.nvim',
      install_path
    }
                      )

  -- https://github.com/wbthomason/packer.nvim/issues/750
  local rtp_addition = vim.fn.stdpath('data') .. '/site/pack/*/start/*'
  if not string.find(vim.o.runtimepath, rtp_addition) then
    vim.o.runtimepath = rtp_addition .. ',' .. vim.o.runtimepath
  end
  vim.notify('Pakcer.nvim 安装完毕')
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('没有安装 packer.nvim')
  return
end

packer.startup(
  {
    function(use)

      -- Packer 可以管理自己本身
      use 'wbthomason/packer.nvim'

      -- start screen
      use 'mhinz/vim-startify'

      -- tokyonight
      use 'folke/tokyonight.nvim'

      -- git commit author
      use 'rhysd/conflict-marker.vim'

      -- filetype
      use { 'nathom/filetype.nvim' }

      --- typescript comment
      use {
        'JoosepAlviste/nvim-ts-context-commentstring',
        config = function()
          require('nvim-treesitter.configs').setup { context_commentstring = { enable = true } }
        end
      }

      -- git diff 
      use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

      ------ tmux navigator
      use 'christoomey/vim-tmux-navigator'

      -- nvim-tree
      use(
        {
          'kyazdani42/nvim-tree.lua',
          requires = 'kyazdani42/nvim-web-devicons',
          config = function()
            require('plugin-config.nvim-tree')
          end
        }
      )

      -- bufferline
      use(
        {
          'akinsho/bufferline.nvim',
          tag = 'v2.*',
          requires = { 'kyazdani42/nvim-web-devicons' },
          config = function()
            require('plugin-config.bufferline')
          end
        }
      )

      -- buffer delete
      use 'moll/vim-bbye'

      -- telescope
      use(
        {
          'nvim-telescope/telescope.nvim',
          requires = {
            'nvim-lua/plenary.nvim',
            'LinArcX/telescope-env.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
          },
          config = function()
            require('plugin-config.telescope')
            -- This will load fzy_native and have it override the default file sorter
          end
        }
      )

      -- clipboard
      use {
        'AckslD/nvim-neoclip.lua',
        requires = {
          { 'tami5/sqlite.lua', module = 'sqlite' },
          { 'nvim-telescope/telescope.nvim' }
          -- {'ibhagwan/fzf-lua'},
        },
        config = function()
          require('plugin-config.neoclip')
        end
      }

      -- gps
      use(
        {
          'SmiteshP/nvim-gps',
          requires = 'nvim-treesitter/nvim-treesitter',
          config = function()
            require('nvim-gps').setup()
          end
        }
      )

      -- statusline
      use {
        'nvim-lualine/lualine.nvim',
        requires = { { 'kyazdani42/nvim-web-devicons', opt = true } },
        config = function()
          require('plugin-config.statusline')
        end
      }

      -- gitsigns
      use(
        {
          'lewis6991/gitsigns.nvim',
          config = function()
            require('gitsigns').setup({ current_line_blame = true })
          end
        }
      )

      -- indent-blankline
      use(
        {
          'lukas-reineke/indent-blankline.nvim',
          config = function()
            require('plugin-config.indent')
          end
        }
      )

      -- nvim-treesitter
      use(
        {
          'nvim-treesitter/nvim-treesitter',
          run = ':TSUpdate',
          config = function()
            require('plugin-config.treesitter')
          end
        }
      )

      -- nvim-autopairs
      use(
        {
          'windwp/nvim-autopairs',
          config = function()
            require('plugin-config.autopairs')
          end
        }
      )

      -- auto-close-tag
      use(
        {
          'windwp/nvim-ts-autotag',
          config = function()
            require('nvim-ts-autotag').setup()
          end
        }
      )

      use({ 'jose-elias-alvarez/null-ls.nvim', requires = { 'nvim-lua/plenary.nvim' } })

      -- waketime
      use 'wakatime/vim-wakatime'

      -- cmp
      use 'hrsh7th/cmp-nvim-lsp'
      use 'hrsh7th/cmp-buffer'
      use 'hrsh7th/cmp-path'
      use 'hrsh7th/cmp-cmdline'
      use 'hrsh7th/nvim-cmp'

      -- snip
      use 'L3MON4D3/LuaSnip'
      use 'saadparwaiz1/cmp_luasnip'
      -- lspkind
      use 'onsails/lspkind-nvim'

      use 'neovim/nvim-lspconfig'
      use 'williamboman/nvim-lsp-installer'
      use 'glepnir/lspsaga.nvim'
      use({ 'jose-elias-alvarez/nvim-lsp-ts-utils', requires = 'nvim-lua/plenary.nvim' })

      -- comment
      use 'tpope/vim-commentary'

      -- surround
      use(
        {
          'ur4ltz/surround.nvim',
          config = function()
            require('plugin-config.surround')
          end
        }
      )

      -- JSON 增强
      use('b0o/schemastore.nvim')

      -- nvim-colorizer
      use(
        {
          'norcalli/nvim-colorizer.lua',
          config = function()
            require('colorizer').setup()
          end
        }
      )

      -- nvim-notify
      -- use {
      --   'rcarriga/nvim-notify',
      --   config = function()
      --     vim.notify = require('notify')
      --   end
      -- }

      -- Packer
      use(
        {
          'folke/noice.nvim',
          config = function()
            require('noice').setup()
          end,
          requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify'
          }
        }
      )
      -- toggle term
      use {
        'akinsho/toggleterm.nvim',
        tag = 'v2.*',
        config = function()
          require('plugin-config.toggleterm')
        end
      }

      if paccker_bootstrap then
        packer.sync()
      end

    end,

    config = {
      -- 并发数限制
      max_jobs = 16,
      -- 自定义源
      git = {
        -- default_url_format = "https://hub.fastgit.xyz/%s",
        -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
        -- default_url_format = "https://gitcode.net/mirrors/%s",
        -- default_url_format = "https://gitclone.com/github.com/%s",
        clone_timeout = 6000
      },
      autoclean = true,
      compile_on_sync = true,
      display = {
        open_fn = function()
          return require('packer.util').float({ border = 'rounded' })
        end
      }
    }
  }
)
