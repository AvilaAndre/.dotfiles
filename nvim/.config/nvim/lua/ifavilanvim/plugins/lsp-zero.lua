return {
	{
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v3.x',
		config = function(_, _opts)
			local lsp_zero = require('lsp-zero')
			lsp_zero.extend_lspconfig()

			local keymap = vim.keymap

			-- if not lsp_zero then return end
			lsp_zero.on_attach(function(_client, bufnr)
				local opts = { buffer = bufnr, silent = true }

				-- see :help lsp-zero-keybindings
				-- to learn the available actions
				-- lsp_zero.default_keymaps({ buffer = bufnr })

				-- show definition, references
				opts.desc = "Show LSP references"
				keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opts)

				-- show lsp definitions
				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				-- go to declaration
				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				-- show lsp implementations
				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				-- show lsp type definitions
				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				-- smart rename
				opts.desc = "Smart rename"
				keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

				-- smart rename
				opts.desc = "Format document"
				keymap.set("n", "<F3>", vim.lsp.buf.format, opts)

				-- see available code actions
				opts.desc = "Show available code actions"
				keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)

				-- show diagnostics
				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				-- show diagnostics for line
				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

				-- jump to previous diagnostic in buffer
				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				-- jump to next diagnostic in buffer
				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				-- show documentation for what is under cursor
				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				-- mapping to restart lsp if necessary
				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
			end)

			-- to learn how to use mason.nvim with lsp-zero
			-- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
			require('mason').setup({})
			require('mason-lspconfig').setup({
				ensure_installed = {},
				handlers = {
					lsp_zero.default_setup,
					jdtls = function() end
				},
			})

			vim.diagnostic.config({
				signs = false
			})

			-- disable auto format on save from zls
			vim.g.zig_fmt_autosave = 0

			-- TODO: Move this configuration elsewhere
			vim.diagnostic.config({ virtual_text = true })

			vim.lsp.config("pylsp", {
				settings = {
					pylsp = {
						plugins = {
							ruff = {
								-- formatter + Linter + isort
								enabled = true,
								formatEnabled = true,
								extendSelect = { "I" },
								lineLength = 88,
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

			vim.lsp.config("gdscript", {
				name = "godot",
				cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
			})

			vim.lsp.config("ltex", {
				settings = {
					ltex = {
						language = "en",
						additionalRules = {
							languageModel = "~/models/ngrams/",
						},
					},
				},
			})
		end
	},
	{ 'neovim/nvim-lspconfig' },
	{ 'L3MON4D3/LuaSnip' }
}
