return {
	"anurag3301/nvim-platformio.lua",
	dependencies = {
		{ "akinsho/nvim-toggleterm.lua" },
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-lua/plenary.nvim" },
	},
	config = function()
		-- set keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>Pr", "<cmd>Piorun<cr>", { desc = "PlatformIO Run" })
		keymap.set("n", "<leader>Pm", "<cmd>Piomon<cr>", { desc = "PlatformIO Monitor" })
	end,
}
