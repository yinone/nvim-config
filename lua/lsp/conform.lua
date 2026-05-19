require("conform").setup({
	format_on_save = function(bufnr)
		-- 禁用 Go 文件的自动格式化（由 autocmds.lua 处理）
		if vim.bo[bufnr].filetype == "go" then
			return nil
		end
		return {
			timeout_ms = 500,
			lsp_format = "fallback",
		}
	end,
	notify_on_error = true,
	log_level = vim.log.levels.WARN,
	formatters_by_ft = {
		typescript = { "prettierd" },
		typescriptreact = { "prettierd" },
		javascriptreact = { "prettierd" },
		json = { "prettierd" },
		css = { "prettierd" },
		scss = { "prettierd" },
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		-- Go 文件由 autocmds.lua 处理，这里禁用 conform 的自动格式化
		go = {},
	},
})
