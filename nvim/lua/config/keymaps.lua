-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>e", function()
  require("mini.files").open()
end, { desc = "Open MiniFiles" })
-- Ctrl + p で現在のファイルの絶対パスをクリップボードにコピー
vim.keymap.set("n", "<C-p>", function()
  local path = vim.fn.expand("%:p") -- %:p で絶対パスを取得
  vim.fn.setreg("+", path) -- システムのクリップボード (+) に格納
  vim.notify("Copied path: " .. path) -- コピーしたことを通知 (mini.notify 等が反応する)
end, { desc = "Copy current file absolute path" })

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true, silent = true })

-- Ctrl + a で現在のバッファの中身を全消し (All delete)
vim.keymap.set("n", "<C-a>", "ggVGd", { desc = "Delete all content in buffer" })

-- Ctrl + w で現在のバッファを削除 (Buffer delete)
-- mini.bufremove が入っている前提での設定
vim.keymap.set("n", "<C-w>", function()
  local bd = require("mini.bufremove").delete
  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 1 then -- Yes
      vim.cmd.write()
      bd(0, false)
    elseif choice == 2 then -- No
      bd(0, true)
    end
  else
    bd(0, false)
  end
end, { desc = "Delete Buffer (Smart)" })
