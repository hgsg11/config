return {
  -- mini.completion の設定
  {
    "echasnovski/mini.completion",
    version = false,
    dependencies = { "echasnovski/mini.fuzzy" }, -- fuzzy を先に読み込む
    event = "InsertEnter", -- 挿入モードに入った時に読み込む
    config = function()
      require("mini.fuzzy").setup()
      require("mini.completion").setup({
        lsp_completion = {
          process_items = require("mini.fuzzy").process_lsp_items,
        },
      })

      -- オプション設定
      vim.opt.complete = { ".", "w", "k", "b", "u" }
      vim.opt.completeopt:append("fuzzy")
      -- 注意1: 辞書ファイルが存在するか確認してください
      if vim.fn.filereadable("/usr/share/dict/words") == 1 then
        vim.opt.dictionary:append("/usr/share/dict/words")
      end

      -- キーコードの定義
      local keys = {
        cn = vim.api.nvim_replace_termcodes("<c-n>", true, false, true),
        cp = vim.api.nvim_replace_termcodes("<c-p>", true, false, true),
        ct = vim.api.nvim_replace_termcodes("<c-t>", true, false, true),
        cd = vim.api.nvim_replace_termcodes("<c-d>", true, false, true),
        cr = vim.api.nvim_replace_termcodes("<cr>", true, false, true),
        cy = vim.api.nvim_replace_termcodes("<c-y>", true, false, true),
      }

      -- <Tab> の設定
      vim.keymap.set("i", "<tab>", function()
        return vim.fn.pumvisible() == 1 and keys.cn or keys.ct
      end, { expr = true })

      -- <S-Tab> の設定
      vim.keymap.set("i", "<s-tab>", function()
        return vim.fn.pumvisible() == 1 and keys.cp or keys.cd
      end, { expr = true })

      -- <CR> (エンター) の設定
      vim.keymap.set("i", "<cr>", function()
        if vim.fn.pumvisible() == 0 then
          -- 注意2: mini.pairs が入っている前提
          local ok, pairs = pcall(require, "mini.pairs")
          return ok and pairs.cr() or keys.cr
        end
        local item_selected = vim.fn.complete_info()["selected"] ~= -1
        return item_selected and keys.cy or (keys.cy .. keys.cr)
      end, { expr = true })
    end,
  },
}
