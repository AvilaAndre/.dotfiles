return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets' },
	version = '1.*',
	opts = {
		keymap = {
			['<Tab>'] = { "accept", "fallback" },
			['<C-y>'] = { "accept", "fallback" },
			['<C-e>'] = { "cancel", "fallback" },
			['<C-k>'] = { 'select_prev', 'fallback' },
			['<C-j>'] = { 'select_next', 'fallback' },
			['<C-p>'] = { 'insert_prev', 'fallback_to_mappings' },
			['<C-n>'] = { 'insert_next', 'fallback_to_mappings' },
			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		},

		appearance = {
			nerd_font_variant = 'mono'
		},

		completion = {
			documentation = { auto_show = false },
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				}
			},
			ghost_text = { enabled = true },

			menu = {
				draw = {
					columns = {
						{ "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 },
					},
				},
			},
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
			per_filetype = { sql = { 'dadbod' } },
			providers = {
				dadbod = { module = "vim_dadbod_completion.blink" },
			}
		},

		snippets = { preset = 'luasnip' },

		fuzzy = { implementation = "prefer_rust_with_warning" }

	},
	opts_extend = { "sources.default" }
}
