return {
	"j-hui/fidget.nvim",
	opts = {
		-- options
		progress = {
			display = {
				done_icon = "",
				render_limit = 1,
				progress_icon = { "clock" },
			},
		},
		integration = {
			["nvim-tree"] = {
				enable = true,
			},
		},
	},
}
