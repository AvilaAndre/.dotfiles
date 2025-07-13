local get_installed_servers = function()
	local supported = require("mason-lspconfig").get_installed_servers()
	local installed_servers = {}

	for _, name in pairs(supported) do
		table.insert(installed_servers, name)
	end

	return installed_servers
end

vim.lsp.enable(get_installed_servers())

vim.diagnostic.config({
	virtual_lines = {
		-- Only show virtual line diagnostics for the current cursor line
		current_line = true,
	},
	virtual_text = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	float = {
		border = "rounded",
		source = true,
	},

	signs = false
})
