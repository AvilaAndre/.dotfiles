return {
	"kawre/leetcode.nvim",
	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	lazy = true,
	dependencies = {
		"nvim-telescope/telescope.nvim",
		-- "ibhagwan/fzf-lua",
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- configuration goes here
		lang = "python3",

		hooks = {
			["question_enter"] = {
				function ()
					vim.cmd([[LspStop pylsp]])
				end
			},
		},
	},
}
