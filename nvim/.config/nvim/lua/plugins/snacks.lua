return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			-- your picker configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		}
	},
	keys = {
		{ "<leader>ff", function() Snacks.picker.files({layout = "bottom"}) end, desc = "Find Files (Root Dir)" },
		{ "<leader>gg", function() Snacks.picker.grep() end, desc = "Grep Files (Root Dir)" },
		{ "<leader><leader>", function() Snacks.picker.smart({layout = "bottom"}) end, desc = "Smart Find Files (Root Dir)" },
		{ "<leader>t", function() Snacks.picker({layout = "telescope"}) end, desc = "Open Snacks.picker" },
		{ "<leader>r", function() Snacks.picker.resume() end, desc = "Open latest Snacks.picker" }
	}
}
