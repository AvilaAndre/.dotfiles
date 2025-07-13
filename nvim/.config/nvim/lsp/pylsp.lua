return {
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
}
