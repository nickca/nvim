return {
	"ziontee113/color-picker.nvim",
	config = function()
		require("color-picker").setup({
			["border"] = "rounded",
			["icons"] = { "", "" },
		})
	end,
}
