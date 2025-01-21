return {
	"utilyre/barbecue.nvim",
	name = "barbecue",
	after = "dracula",
	version = "*",
	dependencies = {
		"SmiteshP/nvim-navic",
		"nvim-tree/nvim-web-devicons", -- optional dependency
	},
	opts = {
		-- configurations go here
	},
	config = function()
		require("barbecue").setup({
			theme = "dracula",
		})
	end,
}
