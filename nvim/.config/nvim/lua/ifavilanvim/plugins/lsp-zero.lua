return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		config = function(_, _opts)
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			-- if not lsp_zero then return end

			lsp_zero.on_attach(function(_client, bufnr)
				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				lsp_zero.default_keymaps({ buffer = bufnr })

				vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', { buffer = bufnr })
			end)

			-- to learn how to use mason.nvim with lsp-zero
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
				},
			})

			vim.diagnostic.config({
				signs = false
			})

			-- disable auto format on save from zls
			vim.g.zig_fmt_autosave = 0

			require("lspconfig")["pylsp"].setup({
				settings = {
					pylsp = {
						plugins = {
							ruff = {
								-- formatter + Linter + isort
								enabled = true,
								formatEnabled = true,
								extendSelect = { "I" },

								ignore = { "I001" },
							},
							-- formatter options
							black = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							-- linter options
							pylint = { enabled = false, executable = "pylint" },
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							-- type checker
							pylsp_mypy = { enabled = true },
							mypy = { enabled = true },
							-- auto-completion options
							jedi_completion = { fuzzy = true },
							-- import sorting
							pyls_isort = { enabled = false },
						},
					},
				},
			})
		end
	},
	{ 'neovim/nvim-lspconfig' },
	{ 'L3MON4D3/LuaSnip' }
}
