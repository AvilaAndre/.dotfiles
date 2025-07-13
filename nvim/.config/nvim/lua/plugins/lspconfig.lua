return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = { 'saghen/blink.cmp' },

	config = function()
		require("mason").setup()

		local lspconfig_defaults = require('lspconfig').util.default_config
		lspconfig_defaults.capabilities = vim.tbl_deep_extend(
			'force',
			lspconfig_defaults.capabilities,
			require('blink.cmp').get_lsp_capabilities()
		)
	end
}
