return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        kotlin_language_server = {},
      },
    },
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        kotlin = { "ktfmt" },
      },
      formatters = {
        ktfmt = {
          prepend_args = { "--google-style" },
        },
      },
    },
  },
}
