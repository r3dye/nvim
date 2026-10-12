-- plugins/init.lua
return {
    -- Telescope: fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                pickers = {
                    find_files = {
                        hidden = true,
                        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
                    },
                },
            })
            local builtin = require('telescope.builtin')
            -- Keymaps
            --
            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--no-ignore",
                        "--glob",
                        "!.git/*",
                    },
                })
            end, { desc = "Find files" })
            -- vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
            vim.keymap.set('n', '<leader>st', builtin.live_grep, { desc = "Live grep" })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List buffers" })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
        end,
    },

    -- nvim-tree: file explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional icons
        config = function()
            require("nvim-tree").setup {
                view = {
                    width = 25,
                    side = "left",
                },
                git = {
                    enable = true,
                },
                filters = {
                    dotfiles = false,
                },
            }
            -- Keymap to toggle file explorer
            vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = "Toggle File Explorer" })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                },
            })
        end,
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha", -- dark
                transparent_background = false,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    telescope = true,
                },
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' }
    },
    {
        "kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },

    { import = "plugins.lsp" }, -- loads lua/plugins/lsp.lu
    { import = "plugins.cmp" },
    { import = "plugins.conform" },
}
