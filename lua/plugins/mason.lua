return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_installation = true,
			ensure_installed = {
				"html",
				"jsonls",
				"pyright",
				"clangd",
				"lua_ls",
				"vimls",
				"denols",
				-- "arduino_language_server",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				-- formatters
				"prettier", -- webdev formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"clang-format", -- c/c++ formatter
				--"black", -- python formatter
				-- linters
				"pylint", -- python linter
				"eslint_d", -- javascript linter
				"cpplint", -- c/c++ linter
				--"luacheck", -- lua linter
			},
		})
	end,
}
