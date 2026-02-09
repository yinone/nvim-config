local myAutoGroup = vim.api.nvim_create_augroup("myAutoGroup", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- filetype with init template
autocmd({ "BufNewFile" }, {
	group = myAutoGroup,
	pattern = { "*.tsx" },
	callback = function()
		vim.api.nvim_command("0r ~/.config/nvim/lua/snippets/react-component.tsx")
		vim.api.nvim_command("set filetype=javascriptreact")
	end,
})

autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
	pattern = "*.html",
	callback = function()
		vim.api.nvim_command("set filetype=html")
	end,
})

autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
	pattern = "*.sh",
	callback = function()
		vim.api.nvim_command("set filetype=bash")
	end,
})

autocmd({ "BufWritePre" }, {
	pattern = "*.go",
	callback = function()
		-- 检查是否有 LSP 客户端连接
		local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
		if #clients == 0 then
			return
		end
		
		-- Neovim 0.11+ 需要显式传递 position_encoding
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
		
		-- 使用同步格式化，并指定客户端
		vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
	end,
})

-- toggle term
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
	vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
	vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
