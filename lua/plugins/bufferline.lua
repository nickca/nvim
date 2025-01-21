return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		options = {
			mode = "buffers",
			separator_style = "slant",
			hover = {
				enabled = true,
				delay = 100,
				reveal = { "close" },
			},
			diagnostics = "nvim_lsp",
		},
	},
}
