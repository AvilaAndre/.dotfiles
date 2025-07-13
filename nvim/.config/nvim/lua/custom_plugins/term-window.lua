return {
	dir = vim.fn.stdpath("config") .. "/lua/custom_plugins/source/term-window",
	name = "term-window",
	config = function()
		require("custom_plugins.source.term-window").setup({
			-- Your plugin's configuration options
		})
	end,
}

