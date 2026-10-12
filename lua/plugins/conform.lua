return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			python = { "isort", "black" },
			javascript = { "prettier", "eslint_d" },
			javascriptreact = { "prettier", "eslint_d" },
			typescript = { "prettier", "eslint_d" },
			typescriptreact = { "prettier", "eslint_d" },
			json = { "prettier" },
			yaml = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
		},
		format_on_save = {
			lsp_fallback = true,
			timeout_ms = 1000,
		},
	},
	keys = {
		{ "<leader>lf", function() require("conform").format({ async = true }) end, desc = "Format file" },
	},
}
