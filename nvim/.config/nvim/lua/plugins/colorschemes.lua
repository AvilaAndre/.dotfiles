return {
	{ "bluz71/vim-moonfly-colors",        lazy = false, priority = 1000, name = "moonfly" },
	{ "ellisonleao/gruvbox.nvim",         lazy = true,  priority = 1000, config = true,     opts = ... },
	{ 'projekt0n/github-nvim-theme',      lazy = true,  priority = 1000 },
	{ "blazkowolf/gruber-darker.nvim",    lazy = true,  priority = 1000 },
	{ "rose-pine/neovim",                 lazy = true,  priority = 1000, name = "rose-pine" },
	{ "fenetikm/falcon",                  lazy = true,  priority = 1000, name = "falcon" },
	{ "nyoom-engineering/oxocarbon.nvim", lazy = true,  priority = 1000 },
	{
		"RRethy/base16-nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require('base16-colorscheme').with_config {
				telescope = false
			}
		end,
	},
	{ "vague2k/vague.nvim", lazy = true,  priority = 1000 },
	{ "NLKNguyen/papercolor-theme", lazy = true,  priority = 1000 },
}
