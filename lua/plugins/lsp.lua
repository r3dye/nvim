return {
    -- Mason core
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        config = function()
            require("mason").setup()
        end,
    },

    -- Mason LSPConfig bridge
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "mason.nvim" },
        config = function()
            require("mason-lspconfig").setup()
        end,
    },

    -- LSP setup
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason.nvim", "mason-lspconfig.nvim" },
        config = function()
            -- Shared on_attach
            local function on_attach(client, bufnr)
                local opts = { noremap = true, silent = true, buffer = bufnr }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                vim.keymap.set("n", "<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, opts)
            end

            -- Enable inline diagnostics (virtual text)
            vim.diagnostic.config({
                virtual_text = {
                    prefix = "●", -- You can also use '▎' or '■'
                    spacing = 2,
                },
                signs = true, -- Gutter signs
                underline = true,
                update_in_insert = false,
            })

            -- Use mason-lspconfig to get installed servers
            local mlsp = require("mason-lspconfig")

            -- Get all installed servers
            local servers = mlsp.get_installed_servers()

            -- Configure each server using new API
            for _, server in ipairs(servers) do
                vim.lsp.config(server, {
                    on_attach = on_attach,
                    flags = { debounce_text_changes = 300 },
                })
                vim.lsp.enable({ server })
            end
        end,
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            -- Configure the linters you want to use
            require("lint").linters_by_ft = {
                python = { "flake8" },
                -- Add other filetypes and linters here
            }

            -- Set up autocommand to run lint on certain events
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
