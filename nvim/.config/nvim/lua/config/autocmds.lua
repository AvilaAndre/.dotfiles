-- adapted from https://github.com/adibhanna/minimal-vim/blob/main/lua/config/autocmds.lua
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		-- defaults:
		-- https://neovim.io/doc/user/news-0.11.html#_defaults

		local picker = require('snacks').picker

		-- TODO: Use fzf-lua
		map("<leader>d", vim.diagnostic.open_float, "Open Diagnostic Float")
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gs", vim.lsp.buf.signature_help, "Signature Documentation")
		map("grd", picker.lsp_declarations, "Goto Declaration")
		map("gri", picker.lsp_implementations, "Goto Implementation")
		map("grr", picker.lsp_references, "References")
		map("grn", vim.lsp.buf.rename, "Rename all references")
		map("grf", vim.lsp.buf.format, "Format")
		map("gra", vim.lsp.buf.code_action, "Code Action")
		map("gO", vim.lsp.buf.document_symbol, "Document Symbol")
		map("<C-s>", vim.lsp.buf.signature_help, "Signature Help")
		map("[d", vim.diagnostic.goto_prev, "Go To Previous Diagnostic")
		map("]d", vim.diagnostic.goto_next, "Go To Next Diagnostic")
		map("<leader>rs", "<cmd>LspRestart<CR>", "Restart LSP")

		map('<leader>q', function() picker.diagnostics({ layout = "ivy_split" }) end, "Open diagnostic [Q]uickfix list")

		local function client_supports_method(client, method, bufnr)
			if vim.fn.has 'nvim-0.11' == 1 then
				return client:supports_method(method, bufnr)
			else
				return client.supports_method(method, { bufnr = bufnr })
			end
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })

			-- When cursor stops moving: Highlights all instances of the symbol under the cursor
			-- When cursor moves: Clears the highlighting
			vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			-- When LSP detaches: Clears the highlighting
			vim.api.nvim_create_autocmd('LspDetach', {
				group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds { group = 'lsp-highlight', buffer = event2.buf }
				end,
			})
		end
	end,
})

local use_indent_cmd = {
	set_indent = function(expandtab, width)
		vim.opt.tabstop = width
		vim.opt.softtabstop = width
		vim.opt.shiftwidth = width
		vim.opt.expandtab = expandtab
	end,

	-- returns true if valid
	validate_args = function(mode, width)
		if not width or not mode then
			return false, "Usage: :UseIndent <spaces|tabs> <width>"
		end
		if mode ~= "spaces" and mode ~= "tabs" then
			return false, "First argument must be 'spaces' or 'tabs'"
		end
		if type(width) ~= "number" or width <= 0 then
			return false, "Second argument must be a positive number"
		end
		return true, ""
	end,

	opts = {
		nargs = "+",
		complete = function(_, line, _)
			local args = vim.split(line, "%s+")
			if #args == 2 then
				return { "spaces", "tabs" }
			elseif #args == 3 then
				return { "2", "4", "8" }
			else
				return {}
			end
		end
	},


	set = function(self)
		vim.api.nvim_create_user_command("IndentationSet", function(opts)
				local mode = opts.fargs[1]
				local width = tonumber(opts.fargs[2])
				local valid, reason = self.validate_args(mode, width)

				if not valid then
					vim.notify(reason)
					return
				end

				self.set_indent(mode == "spaces", width)
				vim.notify(string.format("Indentation set: %s %d", mode, width))
			end,
			self.opts
		)
	end
}

local get_indent_cmd = {
	get_indent_str = function()
		return string.format(
			"Indentation:\ntabstop: %d\nsofttabstop: %d\nshiftwidth: %d\nexpandtab: %s",
			vim.opt.tabstop:get(),
			vim.opt.softtabstop:get(),
			vim.opt.shiftwidth:get(),
			vim.opt.expandtab:get()
		)
	end,

	set = function(self)
		vim.api.nvim_create_user_command(
			"IndentationGet",
			function(_)
				vim.notify(self.get_indent_str())
			end,
			{ nargs = 0 }
		)
	end
}

use_indent_cmd:set()
get_indent_cmd:set()
