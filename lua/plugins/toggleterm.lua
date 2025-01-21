return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			require("toggleterm").setup({
				float_opts = {
					border = "rounded",
				},
			})
		end,
		keys = {
			{ "<leader>/f", "<cmd>ToggleTerm direction=float<cr>", desc = "Terminal floating" },
			{ "<leader>/h", "<cmd>ToggleTerm direction=horizontal size=20<cr>", desc = "Terminal horizontal" },
			{ "<leader>/v", "<cmd>ToggleTerm direction=vertical size=80<cr>", desc = "Terminal vertical" },
		},
	},
}
