return {
	"nvim-treesitter/nvim-treesitter",
	run = ':TSUpdate',
	-- enabled = false
	config = function()
		local configs = require 'nvim-treesitter.configs'
		configs.setup {
			highlight = {
				enable = true
			},
		}
	end,
}
