local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- 新建 tsx 文件时插入组件模板
autocmd("BufNewFile", {
	group = myAutoGroup,
	pattern = "*.tsx",
	callback = function()
		vim.cmd("0r ~/.config/nvim/lua/snippets/react-component.tsx")
		vim.bo.filetype = "typescriptreact"
	end,
})

-- Go 保存时自动 organizeImports + format
autocmd("BufWritePre", {
	group = myAutoGroup,
	pattern = "*.go",
	callback = function()
		local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
		if #clients == 0 then return end

		local encoding = clients[1].offset_encoding or "utf-8"
		local params = vim.lsp.util.make_range_params(0, encoding)
		params.context = { only = { "source.organizeImports" } }

		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		for cid, res in pairs(result or {}) do
			for _, r in pairs(res.result or {}) do
				if r.edit then
					local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-8"
					vim.lsp.util.apply_workspace_edit(r.edit, enc)
				end
			end
		end

		vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
	end,
})

-- terminal 快捷键（用 augroup 替代全局函数）
autocmd("TermOpen", {
	group = myAutoGroup,
	pattern = "term://*",
	callback = function()
		local opts = { buffer = 0 }
		vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "jk",    [[<C-\><C-n>]], opts)
		vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
		vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
		vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
		vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
		vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
	end,
})
