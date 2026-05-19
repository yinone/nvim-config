local status, treesitter = pcall(require, 'nvim-treesitter')
if not status then
  vim.notify('没有找到 nvim-treesitter')
  return
end

local languages = {
	'json', 'html', 'css', 'scss', 'vim', 'lua',
	'javascript', 'typescript', 'tsx', 'bash', 'go',
	'vue', 'git_rebase', 'gitignore', 'gitcommit',
	'gitattributes', 'markdown', 'markdown_inline', 'json5', 'yaml', 'http',
}

local function disable_large_files(_, bufnr)
	local max_filesize = 1024 * 1024
	local max_lines = 5000
	local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(bufnr))
	local lines = vim.api.nvim_buf_line_count(bufnr)
	if (ok and stats and stats.size > max_filesize) or lines > max_lines then
		return true
	end
end

treesitter.setup()

local installed = treesitter.get_installed()
local missing = vim.tbl_filter(function(language)
	return not vim.list_contains(installed, language)
end, languages)
if #missing > 0 then
	treesitter.install(missing)
end

vim.api.nvim_create_autocmd('FileType', {
	pattern = languages,
	callback = function(args)
		if disable_large_files(nil, args.buf) then
			return
		end
		vim.treesitter.start(args.buf)
		vim.wo[0][0].foldmethod = 'expr'
		vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
		vim.wo[0][0].foldlevel = 99
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
