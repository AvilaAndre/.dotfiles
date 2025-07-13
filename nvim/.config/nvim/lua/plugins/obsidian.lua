return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	lazy = true,
	event = {
		-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
		-- refer to `:h file-pattern` for more examples
		"BufReadPre " .. vim.fn.expand "~" .. "/vaults/**/*.md",
		"BufNewFile " .. vim.fn.expand "~" .. "/vaults/**/*.md",
	},
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",

		-- see below for full list of optional dependencies 👇
	},
	opts = {
		workspaces = {
			{
				name = "personal",
				path = "~/vaults/my-obsidian",
			},
			{
				name = "old",
				path = "~/vaults/old-vault",
			},
		},
	},
}
