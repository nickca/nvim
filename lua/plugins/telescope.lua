return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = { "nvim-lua/plenary.nvim" },

	config = function()
		require("telescope").setup({
			defaults = {
				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.45,
						results_width = 0.6,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 0,
				},
				file_ignore_patterns = {
					"iCloud",
				},
				mappings = {
					i = {
						["<C-h>"] = "which_key",
					},
					n = {
						["<C-h>"] = "which_key",
					},
				},
			},
			pickers = {
				find_files = {
					--theme = "ivy",
					hidden = true,
				},
				live_grep = {
					--theme = "ivy",
					hidden = true,
				},
			},
			extensions = {
				file_browser = {
					--theme = "ivy",
					hijack_netrw = true,
					grouped = true,
					hidden = { file_browser = true, folder_browser = true },
				},
			},
		})

		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fe", "<cmd>Telescope live_grep<cr>", { desc = "Fuzzy find grep in files" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
		keymap.set("n", "<leader>fgs", "<cmd>Telescope git_status<cr>", { desc = "Fuzzy find git status" })
		keymap.set("n", "<leader>fgc", "<cmd>Telescope git commits<cr>", { desc = "Fuzzy find git commits" })
		keymap.set("n", "<leader>ft", "<cmd>Telescope treesitter<cr>", { desc = "Fuzzy find Treesitter symbols" })
		keymap.set("n", "<leader>fu", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Commands" })
		keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Keymaps" })
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics<cr>", { desc = "LSP diagnostics" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope spell_suggest<cr>", { desc = "Spelling suggestions" })
		keymap.set(
			"n",
			"<leader>fl",
			"<cmd>Telescope lsp_document_symbols<cr>",
			{ desc = "Fuzzy find LSP document symbols" }
		)
		keymap.set(
			"n",
			"<leader>fw",
			"<cmd>Telescope lsp_workspace_symbols<cr>",
			{ desc = "Fuzzy find LSP workspace symbols" }
		)
		keymap.set("n", "<leader>fc", "<cmd>Telescope colorscheme<cr>", { desc = "Switch colorscheme" })
		keymap.set("n", "<leader>fv", "<cmd>Telescope vim_options<cr>", { desc = "Vim options" })
	end,
}
