return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')
            local cmp = require('cmp')

            -- Enable sign column
            vim.opt.signcolumn = 'yes'

            -- Extend default capabilities
            local lspconfig_defaults = lspconfig.util.default_config
            lspconfig_defaults.capabilities = vim.tbl_deep_extend(
                'force',
                lspconfig_defaults.capabilities,
                cmp_nvim_lsp.default_capabilities()
            )

            -- Auto commands for LSP key mappings
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    local opts = { buffer = event.buf }
                    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                    vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                    vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                    vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                end,
            })

            -- Load the lspconfig plugin
            local lspconfig = require('lspconfig')

            require('lspconfig').gleam.setup({})
            require('lspconfig').ocamllsp.setup({})
            require('lspconfig').clangd.setup({
        cmd = { "clangd", "--compile-commands-dir=build" }
      })
            require('lspconfig').rust_analyzer.setup({})
            require('lspconfig').kotlin_language_server.setup({})
            require('lspconfig').pyright.setup({})
            require('lspconfig').lua_ls.setup({})
            -- CMP setup
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' },
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
                    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = 'select' }),

                    ['<CR>'] = cmp.mapping.confirm({ select = false }),

                    ['<C-Space>'] = cmp.mapping.complete(),

                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                snippet = {
                    expand = function(args)
                        vim.snippet.expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({}),
            })
        end,
    },
    {
        'hrsh7th/cmp-nvim-lsp',
    },
    {
        'hrsh7th/nvim-cmp',
    },
}
