return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		-- { "folke/neodev.nvim", opts = {} },
	},
	config = function()
		local nvim_lsp = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		--local protocol = require("vim.lsp.protocol")

		--[[ local navic = require("nvim-navic")
		local on_attach = function(client, bufnr)
			if client.server_capabilities.documentSymbolProvider then
				navic.attach(client, bufnr)
			end
		end
        ]]

		-- replaced by conform.nvim
		--[[ local on_attach = function(client, bufnr)
            -- format on save
            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("Format", { clear = true }),
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
            end
        end
        ]]

		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		mason_lspconfig.setup_handlers({
			function(server)
				nvim_lsp[server].setup({
					capabilities = capabilities,
				})
			end,
			["denols"] = function()
				nvim_lsp["denols"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
					root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc"),
					settings = {
						enable = true,
						lint = true,
					},
				})
			end,
			["html"] = function()
				nvim_lsp["html"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["jsonls"] = function()
				nvim_lsp["jsonls"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["clangd"] = function()
				nvim_lsp["clangd"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["pyright"] = function()
				nvim_lsp["pyright"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["lua_ls"] = function()
				nvim_lsp["lua_ls"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
			["vimls"] = function()
				nvim_lsp["vimls"].setup({
					--on_attach = on_attach,
					capabilities = capabilities,
				})
			end,
		})
	end,
}
