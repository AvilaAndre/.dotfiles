return {
	{ "tpope/vim-dadbod" },
	{
		"kristijanhusak/vim-dadbod-completion",
		dependencies = "tpope/vim-dadbod",
		lazy = true,
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = "tpope/vim-dadbod",
		lazy = true,
	},
}
