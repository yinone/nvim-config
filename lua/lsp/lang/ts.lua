local keybindings = require("keybindings")

local inlay = {
	parameterNames = { enabled = "literals" },
	parameterTypes = { enabled = true },
	variableTypes = { enabled = true },
	propertyDeclarationTypes = { enabled = true },
	functionLikeReturnTypes = { enabled = true },
	enumMemberValues = { enabled = true },
}

return {
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact" },
	settings = {
		typescript = { inlayHints = inlay },
		javascript = { inlayHints = inlay },
	},
	on_attach = function(client, bufnr)
		vim.lsp.inlay_hint.enable(true)

		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false

		local function buf_set_keymap(...)
			vim.api.nvim_buf_set_keymap(bufnr, ...)
		end
		keybindings.mapLSP(buf_set_keymap)
		keybindings.mapTsLSP(buf_set_keymap)
	end,
}
