return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			preview_config = {
				border = "rounded",
			},
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Next Git hunk" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Previous Git hunk" })

				map("n", "<leader>Gp", gitsigns.preview_hunk, { desc = "Preview Git hunk" })
				map("n", "<leader>Gi", gitsigns.preview_hunk_inline, { desc = "Preview Git hunk inline" })
			end,
		})
	end,
}
