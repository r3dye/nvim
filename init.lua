vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true

require("config.lazy")
vim.opt.clipboard = "unnamedplus"

vim.keymap.set("n", "<leader>w", ":w<CR>")
vim.opt.wrap = false
vim.keymap.set("v", ">", ">gv", { noremap = true, silent = true })
vim.keymap.set("v", "<", "<gv", { noremap = true, silent = true })

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.diagnostic.config({
	virtual_text = {
		source = "if_many", -- shows which LSP the message comes from if multiple
	},
	signs = true, -- keep the signs in the gutter
	underline = true, -- underline problematic code
	update_in_insert = false,
	severity_sort = true,
})

-- Make normal file buffers always modifiable
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*", -- applies to all files
	callback = function()
		local ft = vim.bo.filetype
		-- Exclude special buffer types
		if ft ~= "help" and ft ~= "TelescopePrompt" and ft ~= "terminal" then
			vim.bo.modifiable = true
		end
	end,
})
