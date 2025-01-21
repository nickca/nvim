-- global options {{{
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "
-- }}}

-- winbar {{{
-- attach nvim-navic to the winbar
vim.o.winbar = "%{%v:lua.require('nvim-navic').get_location()%}"
-- disable winbar for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"Outline",
		"Trouble",
		"NvimTree",
		"toggleterm",
		"checkhealth",
		"noice",
		"snacks_dashboard",
	},
	callback = function()
		vim.opt.winbar = ""
	end,
})
-- }}}

-- basic options {{{
vim.opt.foldmethod = "marker"
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true
vim.opt.showmatch = true
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.textwidth = 80
vim.opt.formatoptions = "qrn12"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.encoding = "UTF-8"
vim.opt.title = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mousemoveevent = true
vim.opt.termguicolors = true
vim.opt.autochdir = true
-- }}}

-- grep executable {{{
if vim.fn.executable("rg") then
	vim.opt.grepprg = "rg --vimgrep --no-heading --smart-case"
	vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end
-- }}}

-- format options {{{
if vim.fn.executable("prettier") then
	vim.opt.formatprg = "prettier --stdin-filepath=%"
end

local fo = vim.opt.formatoptions
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		fo:append("l") -- don't break long lines in insert mode
		fo:remove("a") -- don't format paragraphs
		fo:remove("t") -- don't break lines of code for width
		fo:append("c") -- respect width for comments
		fo:remove("o") -- don't insert the comment leader when opening a new line
		fo:remove("r") -- or when pressing enter
		fo:append("n") -- recognize numbered lists
		fo:append("j") -- remove comment leader when joining lines
		fo:remove("2") -- don't indent grade school style
	end,
})
-- }}}

-- cursor {{{
vim.opt.guicursor = {
	"n-v-c:block",
	"i-ci-ve:ver25",
	"r-cr:hor20",
	"o:hor50",
	"i:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
	"sm:block-blinkwait175-blinkoff150-blinkon175",
}
-- }}}

-- mappings {{{
local k = vim.keymap

k.set({ "n", "v" }, "<leader>ca", function()
	vim.lsp.buf.code_action({ apply = true })
end, { desc = "Apply code action", buffer = true })

k.set("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy window" })

k.set("n", "<C-s>", "<cmd>:update!", { desc = "Save file if changed" })

k.set("n", "gl", "`.", { desc = "Last changed point" })

k.set("n", "<C-q>", function()
	-- https://stackoverflow.com/a/47074633
	-- https://codereview.stackexchange.com/a/282183

	local results = {}
	local buffers = vim.api.nvim_list_bufs()

	for _, buffer in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buffer) then
			local filename = vim.api.nvim_buf_get_name(buffer)
			if filename ~= "" then
				table.insert(results, filename)
			end
		end
	end
	local curr_buf = vim.api.nvim_buf_get_name(0)
	if #results > 1 or curr_buf == "" then
		vim.cmd("bd")
	else
		vim.cmd("quit")
	end
end, { silent = false, desc = "bd or quit" })
-- line text objects
-- https://vimrcfu.com/snippet/269
k.set(
	"o",
	"al",
	[[v:count==0 ? ":<c-u>normal! 0V$h<cr>" : ":<c-u>normal! V" . (v:count) . "jk<cr>" ]],
	{ expr = true, desc = "around line" }
)
k.set(
	"v",
	"al",
	[[v:count==0 ? ":<c-u>normal! 0V$h<cr>" : ":<c-u>normal! V" . (v:count) . "jk<cr>" ]],
	{ expr = true, desc = "around line" }
)
k.set(
	"o",
	"il",
	[[v:count==0 ? ":<c-u>normal! ^vg_<cr>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<cr>"]],
	{ expr = true, desc = "inside line" }
)
k.set(
	"v",
	"il",
	[[v:count==0 ? ":<c-u>normal! ^vg_<cr>" : ":<c-u>normal! ^v" . (v:count) . "jkg_<cr>"]],
	{ expr = true, desc = "inside line" }
)
-- }}}

-- lazy plugin manager {{{
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- }}}
