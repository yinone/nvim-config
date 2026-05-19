return {
	settings = {
		workingDirectories = { mode = "auto" },
	},
	on_attach = function(client, bufnr)
		-- 保存时自动应用 ESLint --fix
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.code_action({
					context = { only = { "source.fixAll.eslint" } },
					apply = true,
				})
			end,
		})
	end,
}
