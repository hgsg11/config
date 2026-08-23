return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.codelens.enabled = true

      local gopls = opts.servers.gopls.settings.gopls
      local overrides = {
        analyses = {
          nilness = true,
          unusedparams = true,
          unusedwrite = true,
        },
        staticcheck = true,
        gofumpt = true,
        usePlaceholders = true,
        directoryFilters = { "-**/node_modules", "-**/.git", "-**/vendor" },
        semanticTokens = true,
        codelenses = {
          generate = true,
          regenerate_cgo = true,
          run_govulncheck = true,
          test = true,
          tidy = true,
          upgrade_dependency = true,
          vendor = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          ignoredError = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
      }

      opts.servers.gopls.settings.gopls = vim.tbl_deep_extend("force", gopls, overrides)
      opts.servers.gopls.settings.gopls.completeUnimported = nil
    end,
  },
}
