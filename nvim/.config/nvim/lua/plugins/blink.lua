return {
	'saghen/blink.cmp',
	dependencies = { 'rafamadriz/friendly-snippets', 'L3MON4D3/LuaSnip' },
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
			documentation = { auto_show = true },
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
						{ "kind_icon", gap = 1 }, { "label", "label_description", gap = 1 }, { "kind", gap = 1 },
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

		fuzzy = { implementation = "prefer_rust_with_warning" },

		signature = { enabled = true },

		cmdline = {
			enabled = true,
			sources = function()
				local type = vim.fn.getcmdtype()
				-- Search forward and backward
				if type == '/' or type == '?' then return { 'buffer' } end
				-- Commands
				if type == ':' or type == '@' then return { 'cmdline' } end
				return {}
			end,

			completion = {
				list = {
					selection = {
						preselect = false,
						auto_insert = true,
					},
				},
			}
		}

	},
	opts_extend = { "sources.default" }
}
