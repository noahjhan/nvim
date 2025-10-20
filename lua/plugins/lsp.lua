return {
  -- LuaSnip
  {
    'L3MON4D3/LuaSnip',
    config = function()
      local ok, luasnip = pcall(require, 'luasnip')
      if not ok then
        vim.notify('LuaSnip not found', vim.log.levels.WARN)
        return
      end
      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },

  -- nvim-cmp + sources
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local ok_cmp, cmp = pcall(require, 'cmp')
      if not ok_cmp then
        vim.notify('nvim-cmp not found', vim.log.levels.WARN)
        return
      end
      local ok_lu, luasnip = pcall(require, 'luasnip')
      if not ok_lu then
        luasnip = nil
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            if luasnip then
              luasnip.lsp_expand(args.body)
            end
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
            { name = 'buffer' },
            { name = 'path' },
          }),
      })
    end,
  },

  -- LSP servers (Neovim 0.11+ compatible)
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok_cmp then
        if type(cmp_nvim_lsp.default_capabilities) == 'function' then
          capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        elseif type(cmp_nvim_lsp.update_capabilities) == 'function' then
          capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
        end
      end

      local on_attach = function(client, bufnr)
        local function bufmap(mode, lhs, rhs, opts)
          opts = opts or { noremap = true, silent = true }
          vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
        bufmap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
      end

      local util = require("lspconfig.util")

      -- Helper to pick gopls
      local gopls_cmd = { vim.fn.exepath('gopls') }
      if gopls_cmd[1] == '' then
        gopls_cmd = { '/Users/noahhan/go/bin/gopls' }
      end

      local servers = {
        gopls = {
          cmd = gopls_cmd,
          filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
          root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
        },
        clangd = {
          cmd = { 'clangd' },  -- REQUIRED
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
          root_dir = util.root_pattern('compile_commands.json', '.git'),
        },
        lua_ls = {
          cmd = { 'lua-language-server' },  -- REQUIRED
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              diagnostics = { globals = { 'vim' } },
              workspace = {
                library = vim.api.nvim_get_runtime_file('', true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
      }
      -- Start servers using new API
      for name, config in pairs(servers) do
        vim.lsp.start({
          name = name,
          on_attach = on_attach,
          capabilities = capabilities,
          cmd = config.cmd,
          filetypes = config.filetypes,
          root_dir = config.root_dir,
          settings = config.settings,
        })
      end
    end,
  },
}

