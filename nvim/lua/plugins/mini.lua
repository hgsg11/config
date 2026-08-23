return {
  {
    "nvim-mini/mini.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
      require("mini.notify").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
      require("mini.starter").setup()

      require("mini.ai").setup({ n_lines = 500 })
      require("mini.align").setup()
      require("mini.bracketed").setup()
      require("mini.bufremove").setup()
      require("mini.comment").setup()
      require("mini.completion").setup()
      require("mini.cursorword").setup()
      require("mini.diff").setup()
      require("mini.extra").setup()
      require("mini.files").setup({
        mappings = {
          -- Keep `l` for navigation and use Enter to open a file and close
          -- the explorer (`go_in_plus`).
          go_in = "l",
          go_in_plus = "<CR>",
        },
        options = {
          permanent_delete = false,
          use_as_default_explorer = true,
          lsp_timeout = 1000,
        },
        windows = {
          max_number = math.huge,
          preview = true,
          width_focus = 50,
          width_nofocus = 15,
          width_preview = 50,
        },
      })
      require("mini.git").setup()
      require("mini.hipatterns").setup()
      require("mini.indentscope").setup()
      require("mini.jump").setup()
      require("mini.jump2d").setup()
      require("mini.move").setup()
      require("mini.operators").setup()
      require("mini.pairs").setup()
      require("mini.pick").setup()
      require("mini.sessions").setup()
      require("mini.snippets").setup()
      require("mini.splitjoin").setup()
      require("mini.surround").setup()
      require("mini.trailspace").setup()
      require("mini.visits").setup()

      local clue = require("mini.clue")
      clue.setup({
        triggers = {
          { mode = { "n", "x" }, keys = "<Leader>" },
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = { "n", "x" }, keys = "g" },
          { mode = { "n", "x" }, keys = "z" },
          { mode = { "n", "x" }, keys = '"' },
          { mode = { "i", "c" }, keys = "<C-r>" },
          { mode = "i", keys = "<C-x>" },
        },
        clues = {
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.square_brackets(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),
        },
      })

      vim.opt.complete = { ".", "w", "k", "b", "u" }
      vim.opt.completeopt:append("fuzzy")

      local keys = {
        next = vim.keycode("<C-n>"),
        prev = vim.keycode("<C-p>"),
        tab = vim.keycode("<C-t>"),
        shift_tab = vim.keycode("<C-d>"),
        enter = vim.keycode("<CR>"),
        accept = vim.keycode("<C-y>"),
      }

      vim.keymap.set("i", "<Tab>", function()
        return vim.fn.pumvisible() == 1 and keys.next or keys.tab
      end, { expr = true, desc = "Next completion or indent" })

      vim.keymap.set("i", "<S-Tab>", function()
        return vim.fn.pumvisible() == 1 and keys.prev or keys.shift_tab
      end, { expr = true, desc = "Previous completion or unindent" })

      vim.keymap.set("i", "<CR>", function()
        if vim.fn.pumvisible() == 0 then
          return require("mini.pairs").cr()
        end
        local item_selected = vim.fn.complete_info().selected ~= -1
        return item_selected and keys.accept or (keys.accept .. keys.enter)
      end, { expr = true, desc = "Accept completion or enter" })
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "atom-dark",
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local capabilities = require("mini.completion").get_lsp_capabilities()
      -- Neovim's recursive file watcher can exhaust file descriptors on large
      -- workspaces. gopls does its own workspace tracking, so don't let the
      -- server dynamically register an additional watcher here.
      capabilities.workspace = capabilities.workspace or {}
      capabilities.workspace.didChangeWatchedFiles = { dynamicRegistration = false }
      opts.servers["*"].capabilities = vim.tbl_deep_extend("force", opts.servers["*"].capabilities or {}, capabilities)
    end,
  },
}
