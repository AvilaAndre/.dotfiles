return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = { 'saghen/blink.cmp' },

	-- example using `opts` for defining servers
	opts = {
		servers = {
			lua_ls = {}
		}
	},
	config = function()
		local lspconfig_defaults = require('lspconfig').util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lspconfig_defaults.capabilities,
			require('blink.cmp').get_lsp_capabilities()
		)
	end
}
