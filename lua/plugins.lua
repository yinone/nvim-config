local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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

	-- snacks.nvim - 集成 dashboard / bigfile / notifier / statuscolumn 等
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			notifier = { enabled = true, timeout = 3000 },
			quickfile = { enabled = true },
			statuscolumn = { enabled = false }, -- 已有 gitsigns 接管 sign 列
			words = { enabled = true },
			dashboard = {
				preset = {
					keys = {
						{ icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
						{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
						{ icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
						{ icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
						{ icon = " ", key = "c", desc = "Config", action = ":e $MYVIMRC" },
						{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy" },
						{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
					},
				},
				sections = {
					{ section = "header" },
					{ section = "keys", gap = 1, padding = 1 },
					{ section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
					{ section = "projects", icon = " ", title = "Projects", indent = 2, padding = 1 },
					{ section = "startup" },
				},
			},
		},
	},

	-- tokyonight - 优先加载（颜色主题）
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
	},

	-- tmux/vim pane navigation
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},

	-- git commit author - 按需加载
	{
		"rhysd/conflict-marker.vim",
		event = "VeryLazy",
	},

	-- treesitter textobjects - 依赖 treesitter
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		event = "VeryLazy",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter-textobjects").setup({
				select = {
					lookahead = true,
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
						["@class.outer"] = "<c-v>",
					},
					include_surrounding_whitespace = true,
				},
			})

			local select = require("nvim-treesitter-textobjects.select")
			vim.keymap.set({ "x", "o" }, "af", function()
				select.select_textobject("@function.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "if", function()
				select.select_textobject("@function.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ac", function()
				select.select_textobject("@class.outer", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "ic", function()
				select.select_textobject("@class.inner", "textobjects")
			end)
			vim.keymap.set({ "x", "o" }, "as", function()
				select.select_textobject("@local.scope", "locals")
			end)
		end,
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local ok, telescope = pcall(require, "telescope")
			if not ok then
				vim.notify("没有找到 telescope")
				return
			end
			telescope.setup({
				defaults = {
					initial_mode = "insert",
					layout_strategy = "horizontal",
					layout_config = { width = 0.95, preview_width = 0.55 },
				},
			})
			pcall(telescope.load_extension, "fzf")
		end,
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
		branch = "main",
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

	-- blink.cmp - Rust 实现的高性能补全
	{
		"saghen/blink.cmp",
		version = "1.*", -- 使用 release tag，自动下载预编译 fuzzy 二进制
		event = "InsertEnter",
		dependencies = {
			{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
			"rafamadriz/friendly-snippets",
		},
		opts = {
			keymap = {
				preset = "default",
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			},
			appearance = { nerd_font_variant = "mono" },
			completion = {
				keyword = { range = "full" },
				trigger = { show_in_snippet = true },
				list = { selection = { preselect = true, auto_insert = false } },
				menu = {
					border = "rounded",
					max_height = 12,
					draw = { treesitter = { "lsp" } },
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
					window = { border = "rounded", max_width = 80, max_height = 15 },
				},
				ghost_text = { enabled = false },
			},
			signature = { enabled = true, window = { border = "rounded" } },
			sources = {
				default = { "lsp", "snippets", "buffer", "path" },
				providers = {
					lsp = { score_offset = 100 },
					snippets = { score_offset = 75 },
					buffer = { score_offset = 50, max_items = 10 },
					path = { score_offset = 25 },
				},
			},
			snippets = { preset = "luasnip" },
			cmdline = {
				keymap = { preset = "cmdline" },
				completion = { menu = { auto_show = true } },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},

	-- JSON / YAML schema 增强
	{
		"b0o/schemastore.nvim",
		ft = { "json", "jsonc", "yaml" },
	},

	-- nvim-colorizer - 文件打开时加载
	-- norcalli 版已停止维护且使用了废弃的 vim.tbl_flatten，改用维护中的 catgoose drop-in fork
	{
		"catgoose/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("colorizer").setup()
		end,
	},

	-- oil.nvim - 把目录当 buffer 编辑
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		keys = {
			{ "-", "<cmd>Oil<cr>", desc = "Open parent directory (oil)" },
		},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			default_file_explorer = false, -- 与 nvim-tree 共存，不抢 netrw 角色
			view_options = { show_hidden = true },
			keymaps = {
				["q"] = "actions.close",
				["<C-h>"] = false, -- 让给 tmux-navigator
				["<C-l>"] = false,
			},
		},
	},

	-- flash.nvim - 跳转
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "s", function() require("flash").jump() end, mode = { "n", "x", "o" }, desc = "Flash" },
			{ "S", function() require("flash").treesitter() end, mode = { "n", "x", "o" }, desc = "Flash Treesitter" },
			{ "r", function() require("flash").remote() end, mode = "o", desc = "Remote Flash" },
		},
	},

	-- which-key - 快捷键提示
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 300,
			icons = { mappings = false },
			spec = {
				{ "<leader>f", group = "Find / File" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>g", group = "Git" },
				{ "<leader>l", group = "LSP" },
				{ "<leader>n", group = "NvimTree" },
				{ "<leader>R", group = "REST" },
				{ "<leader>D", group = "Debug" },
			},
		},
		keys = {
			{
				"<leader>?",
				function() require("which-key").show({ global = false }) end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
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

	-- kulala - REST client，在 .http 文件里直接发请求调接口
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		keys = {
			{ "<leader>Rs", function() require("kulala").run() end, desc = "Send request" },
			{ "<leader>Ra", function() require("kulala").run_all() end, desc = "Send all requests" },
			{ "<leader>Rr", function() require("kulala").replay() end, desc = "Replay last request" },
			{ "<leader>Rc", function() require("kulala").copy() end, desc = "Copy as cURL" },
			{ "<leader>Ri", function() require("kulala").inspect() end, desc = "Inspect request" },
		},
		opts = {},
	},

	-- nvim-dap - Go 调试（delve）
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"theHamsta/nvim-dap-virtual-text",
			"leoluz/nvim-dap-go",
		},
		keys = {
			{ "<leader>Db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
			{ "<leader>Dc", function() require("dap").continue() end, desc = "Continue / Start" },
			{ "<leader>Di", function() require("dap").step_into() end, desc = "Step into" },
			{ "<leader>Do", function() require("dap").step_over() end, desc = "Step over" },
			{ "<leader>DO", function() require("dap").step_out() end, desc = "Step out" },
			{ "<leader>Dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
			{ "<leader>Dl", function() require("dap").run_last() end, desc = "Run last" },
			{ "<leader>Dt", function() require("dap").terminate() end, desc = "Terminate" },
			{ "<leader>Du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
			{ "<leader>DT", function() require("dap-go").debug_test() end, desc = "Debug nearest Go test" },
		},
		config = function()
			require("plugin-config.dap")
		end,
	},

}, {
	defaults = { lazy = true }, -- 默认所有插件都延迟加载
	rocks = { enabled = false },
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = false }, -- 禁用自动检查更新，提升启动速度
	change_detection = { notify = false },
	git = { timeout = 300 }, -- 默认 120 太短，大仓库（如 snacks）容易超时

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
