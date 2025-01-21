return {
	"robitx/gp.nvim",
	config = function()
		local conf = {
			-- For customization, refer to Install > Configuration in the Documentation/Readme
			openai_api_key = os.getenv("OPENAI_API_KEY"),
			providers = {
				openai = {
					disable = true,
				},
				googleai = {
					disable = false,
					secret = os.getenv("GOOGLEAI_API_KEY"),
				},
			},
		}
		require("gp").setup(conf)

		-- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
	end,
}
