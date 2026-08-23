vim.keymap.set("n", "<leader>e", function()
  local files = require("mini.files")
  local current_file = vim.api.nvim_buf_get_name(0)
  local anchor = files.get_latest_path() or LazyVim.root()

  -- Keep the existing anchor. `open(current_file)` must not be used here,
  -- because its argument becomes a new MiniFiles anchor.
  files.open(anchor)

  if current_file == "" or vim.uv.fs_stat(current_file) == nil then
    return
  end

  local relative = vim.fs.relpath(anchor, current_file)
  if relative == nil then
    return
  end

  local branch = { anchor }
  local path = anchor
  for part in relative:gmatch("[^/]+") do
    path = vim.fs.joinpath(path, part)
    branch[#branch + 1] = path
  end
  files.set_branch(branch)
end, { desc = "MiniFiles (current file)" })

-- <leader><space> は Snacks Picker のまま残す。
vim.keymap.set("n", "<leader>,", function()
  MiniPick.builtin.buffers()
end, { desc = "Buffers (MiniPick)" })

vim.keymap.set("n", "<leader>/", function()
  MiniPick.builtin.grep_live()
end, { desc = "Grep (MiniPick)" })

vim.keymap.set("n", "<leader>:", function()
  MiniExtra.pickers.commands()
end, { desc = "Commands (MiniPick)" })

vim.keymap.set("n", "<leader>ff", function()
  MiniPick.builtin.files()
end, { desc = "Find files (MiniPick)" })

vim.keymap.set("n", "<leader>fb", function()
  MiniPick.builtin.buffers()
end, { desc = "Buffers (MiniPick)" })

vim.keymap.set("n", "<leader>fh", function()
  MiniPick.builtin.help()
end, { desc = "Help (MiniPick)" })

vim.keymap.set("n", "<leader>fr", function()
  MiniExtra.pickers.oldfiles()
end, { desc = "Recent files (MiniPick)" })

vim.keymap.set("n", "<leader>xx", function()
  MiniExtra.pickers.diagnostic({ scope = "all" })
end, { desc = "Diagnostics (MiniPick)" })

vim.keymap.set("n", "<leader>qs", function()
  MiniSessions.write()
end, { desc = "Save session" })

vim.keymap.set("n", "<leader>ql", function()
  MiniSessions.select("read")
end, { desc = "Load session" })

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
