return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{ "hrsh7th/cmp-buffer", lazy = true }, -- source for text in buffer
		{ "hrsh7th/cmp-path", lazy = true }, -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			--install jsregexp (optional!).
			--build = "make install_jsregexp",
			lazy = true,
		},
		{ "saadparwaiz1/cmp_luasnip", lazy = true },
		{ "rafamadriz/friendly-snippets", lazy = true },
		{ "onsails/lspkind.nvim", lazy = true }, -- vs-code like pictograms
		{ "hrsh7th/cmp-cmdline", lazy = true },
		{ "hrsh7th/cmp-nvim-lsp-signature-help", lazy = true },
		{ "hrsh7th/cmp-nvim-lsp-document-symbol", lazy = true },
		{ "hrsh7th/cmp-emoji", lazy = true }, -- 👊 🍆
		{ "hrsh7th/cmp-nvim-lua", lazy = true },
		{ "ray-x/cmp-treesitter", lazy = true },
		{
			"folke/lazydev.nvim",
			lazy = true,
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- See the configuration section for more details
					-- Load luvit types when the `vim.uv` word is found
					-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
	},
	config = function()
		local source_mapping = {
			nvim_lsp = "[LSP]",
			nvim_lua = "[LUA]",
			luasnip = "[SNIP]",
			buffer = "[BUF]",
			path = "[PATH]",
			treesitter = "[TREE]",
		}
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local luasnip = require("luasnip")
		luasnip.config.set_config({
			enable_autosnippets = true,
		})
		local has_words_before = function()
			unpack = unpack or table.unpack
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
		end

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			formatting = {
				fields = { "menu", "abbr", "kind" },
				expandable_indicator = true,
				format = lspkind.cmp_format({
					mode = "symbol_text",
					maxwidth = {
						menu = 50,
						abbr = 50,
					},
					ellipsis_char = "…",
					show_labelDetails = true,
					menu = source_mapping,
				}),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-d>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.close(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				-- Super tab
				["<Tab>"] = cmp.mapping(function(fallback)
					local col = vim.fn.col(".") - 1

					if cmp.visible() then
						cmp.select_next_item({ behavior = "select" })
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
						fallback()
					else
						cmp.complete()
					end
				end, { "i", "s" }),
				-- Super shift tab
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item({ behavior = "select" })
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{
					name = "nvim_lsp",
					priority = 200,
					group_index = 1,
				},
				{
					name = "luasnip",
					priority = 150,
					group_index = 1,
					option = { show_autosnippets = true, use_show_condition = false },
				},
				{
					name = "nvim_lua",
					entry_filter = function()
						if vim.bo.filetype ~= "lua" then
							return false
						end
						return true
					end,
					priority = 100,
					group_index = 1,
				},
				{
					name = "lazydev",
					group_index = 0,
					entry_filter = function()
						if vim.bo.filetype ~= "lua" then
							return false
						end
						return true
					end,
					priority = 100,
				},
				{
					name = "buffer",
					max_item_count = 5,
					keyword_length = 2,
					priority = 90,
					entry_filter = function(entry)
						return not entry.exact
					end,
					option = {
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end,
					},
					group_index = 2,
				},
				{
					name = "treesitter",
					max_item_count = 5,
					priority = 70,
					group_index = 3,
					entry_filter = function(entry, vim_item)
						if entry.kind == 15 then
							local cursor_pos = vim.api.nvim_win_get_cursor(0)
							local line = vim.api.nvim_get_current_line()
							local next_char = line:sub(cursor_pos[2] + 1, cursor_pos[2] + 1)
							if next_char == '"' or next_char == "'" then
								vim_item.abbr = vim_item.abbr:sub(1, -2)
							end
						end
						return vim_item
					end,
				},
				{
					name = "path",
					group_index = 4,
					priority = 50,
				},
				{ name = "nvim_lsp_signature_help" },
				{
					name = "emoji",
					group_index = 4,
					priority = 50,
				},
			}),
		})
		cmp.setup.cmdline(":", {
			mapping = cmp.mapping.preset.cmdline({
				["<Down>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "c" }),
				["<Up>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "c" }),
			}),
			sources = cmp.config.sources({
				{ name = "path" },
			}, {
				{
					name = "cmdline",
					option = {
						ignore_cmds = { "Man", "!" },
					},
				},
			}),
		})
		cmp.setup.cmdline({ "/", "?" }, {
			mapping = cmp.mapping.preset.cmdline({
				["<Down>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
						-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
						-- that way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "c" }),
				["<Up>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "c" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp_document_symbol" },
				{ name = "buffer" },
			}),
		})
		vim.cmd([[
        set completeopt=menuone,noinsert,noselect
        highlight! default link CmpItemKind CmpItemMenuDefault
        ]])
	end,
}
