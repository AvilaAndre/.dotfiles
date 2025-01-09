return {
    require("ifavilanvim.plugins.colorschemes"),
    require("ifavilanvim.plugins.cmp"),
    require("ifavilanvim.plugins.telescope"),
    require("ifavilanvim.plugins.treesitter"),
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    require("ifavilanvim.plugins.mason"),
    require("ifavilanvim.plugins.lspconfig"),
    require("ifavilanvim.plugins.lsp-zero"),
    require("ifavilanvim.plugins.modicator"),
    require("ifavilanvim.plugins.todo-comments"),
    require("ifavilanvim.plugins.trouble"),
    require("ifavilanvim.plugins.gitsigns"),
    require("ifavilanvim.plugins.lightline"),
    require("ifavilanvim.plugins.guess-indent"),
    require("ifavilanvim.plugins.dadbod"),
    require("ifavilanvim.plugins.mini-files"),
    -- require("ifavilanvim.plugins.copilot"),
    { "nvzone/showkeys", cmd = "ShowkeysToggle" },
    -- require("ifavilanvim.plugins.markview"),
    -- require("ifavilanvim.plugins.nvim-metals")

    {
        dir = vim.fn.stdpath("config") .. "/lua/ifavilanvim/custom_plugins/term-window",
        name = "term-window",
        config = function()
            require("ifavilanvim.custom_plugins.term-window").setup({
                -- Your plugin's configuration options
            })
        end,
    }
}
