require("config.options")
require("config.keymaps")
require("core.lazy")
require("core.lsp")

-- theme
vim.o.background = "dark"
vim.cmd([[colorscheme vague]])

-- line
local ok, lualine = pcall(require, "lualine")
if ok then
  lualine.setup()
end

require("config.autocmds")
