return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = function()
		return {
			{ "<leader>t",  "<cmd>Telescope<cr>",             desc = "Telescope" },
			{ "<leader>pf", "<cmd>Telescope find_files<cr>",  desc = "Find Project Files" },
			{ "<C-p>",      "<cmd>Telescope git_files<cr>",   desc = "Git Files" },
			{ "<leader>ps", "<cmd>Telescope live_grep<cr>", desc = "Grep in File" },
		}
	end,
	opts = {
		defaults = {
			mappings = {
				i = {
					["<C-j>"] = "move_selection_next",
					["<C-k>"] = "move_selection_previous",
				},
			},
		},
		pickers = {
			find_files = {
				theme = "ivy"
			},
			live_grep = {
				theme = "ivy"
			},
			grep_string = {
				theme = "ivy"
			},
			commands = {
				theme = "dropdown"
			},
		}
	},
	lazy = false
}
