local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

	-- start screen - 延迟加载
	{
		"mhinz/vim-startify",
		event = "VimEnter",
	},

	-- tokyonight - 优先加载（颜色主题）
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},

	-- git commit author - 按需加载
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
	},

	-- treesitter textobjects - 依赖 treesitter
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},

	-- git diff - 按需加载
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles" },
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- nvim-tree - 按需加载
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeToggle", "NvimTreeFindFile" },
		keys = {
			{ "<leader>n", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
			{ "<leader>f", "<cmd>NvimTreeFindFile<cr>", desc = "Find File in NvimTree" },
		},
		config = function()
			require("plugin-config.nvim-tree")
		end,
	},

	-- lspsaga - 按需加载
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("plugin-config.lspsaga")
		end,
	},

	-- comment - 按需加载
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "VeryLazy",
		config = function()
			require("ts_context_commentstring").setup({ enable_autocmd = false })
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = "VeryLazy",
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	-- bufferline - UI 插件，延迟加载
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("plugin-config.bufferline")
		end,
	},

	-- buffer delete - 按需加载
	{
		"moll/vim-bbye",
		cmd = "Bdelete",
	},

	-- telescope - 按需加载
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		keys = {
			{ "<C-p>", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
			{ "<C-g>", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
			{ "<leader>b", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		},
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("plugin-config.telescope")
		end,
	},

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
		event = "VeryLazy",
	},

	-- gps - 延迟加载
	{
		"SmiteshP/nvim-navic",
		event = "LspAttach",
	},

	-- statusline - UI 插件，延迟加载
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
		config = function()
			require("plugin-config.statusline")
		end,
	},

	-- gitsign - 文件打开时加载
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({ current_line_blame = true })
		end,
	},

	-- indent-blankline - 文件打开时加载
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("plugin-config.indent")
		end,
	},

	-- nvim-treesitter - 文件打开时加载
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPre", "BufNewFile" },
		build = ":TSUpdate",
		config = function()
			require("plugin-config.treesitter")
		end,
	},

	-- nvim-autopairs - 插入模式加载
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("plugin-config.autopairs")
		end,
	},

	-- auto-close-tag - 文件打开时加载
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},

	-- conform - 保存时加载
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {},
	},

	-- waketime - 后台统计，延迟加载
	{
		"wakatime/vim-wakatime",
		event = "VeryLazy",
	},

	-- mason - 命令触发
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {},
	},

	{
		"mason-org/mason-lspconfig.nvim",
		event = "VeryLazy",
		opts = {},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
	},

	-- cmp - 插入模式加载
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
	},

	-- ts utils - 文件类型触发
	{
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		dependencies = "nvim-lua/plenary.nvim",
	},

	-- JSON 增强 - JSON 文件触发
	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc" },
	},

	-- nvim-colorizer - 文件打开时加载
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup()
		end,
	},

	-- surround - 按需加载
	{
		"kylechui/nvim-surround",
		keys = {
			{ "ys", "<Plug>(nvim-surround-normal)", desc = "Add surround" },
			{ "ds", "<Plug>(nvim-surround-delete)", desc = "Delete surround" },
			{ "cs", "<Plug>(nvim-surround-change)", desc = "Change surround" },
		},
		config = function()
			require("nvim-surround").setup({})
		end,
	},

}, {
	defaults = { lazy = true }, -- 默认所有插件都延迟加载
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = false }, -- 禁用自动检查更新，提升启动速度
	change_detection = { notify = false },
	performance = {
		cache = { enabled = true },
		reset_packpath = true,
		rtp = {
			reset = true,
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
