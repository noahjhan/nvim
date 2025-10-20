-- Neovim plugin spec: LSP, nvim-cmp and LuaSnip (Neovim 0.11+ friendly)
-- Drop this file into your config (e.g. lua/plugins/lsp.lua) and require it from your plugin manager.
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
      -- load vscode-style snippets (lazy)
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

  -- lspconfig and server setups
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      local ok, lspconfig = pcall(require, 'lspconfig')
      if not ok then
        vim.notify('nvim-lspconfig not found', vim.log.levels.ERROR)
        return
      end

      -- Build capabilities robustly for different cmp_nvim_lsp versions
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      if ok_cmp then
        if type(cmp_nvim_lsp.default_capabilities) == 'function' then
          capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
        elseif type(cmp_nvim_lsp.update_capabilities) == 'function' then
          capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
        end
      end

      -- simple on_attach for common LSP keymaps (customize as you like)
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

      local util = lspconfig.util

      -- Helper to pick gopls from PATH or fallback to your personal path
      local gopls_cmd = { vim.fn.exepath('gopls') }
      if gopls_cmd[1] == '' then
        gopls_cmd = { '/Users/noahhan/go/bin/gopls' }
      end

      -- gopls
      lspconfig.gopls.setup({
        cmd = gopls_cmd,
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
      })

      -- clangd (C/C++)
      lspconfig.clangd.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_dir = util.root_pattern('compile_commands.json', '.git'),
      })

      -- lua_ls
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        on_attach = on_attach,
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
      })
    end,
  },
}
