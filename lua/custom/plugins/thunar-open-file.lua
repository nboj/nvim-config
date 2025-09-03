-- utils/open_in_explorer.lua (or in your init.lua)
local function get_dir_under_cursor_or_buf()
  -- If you're in Oil, use its API to get a real filesystem path
  local ok, oil = pcall(require, "oil")
  if ok and vim.bo.filetype == "oil" and oil.get_current_dir then
    return oil.get_current_dir()
  end

  -- Otherwise use the current file or fallback to CWD
  local name = vim.api.nvim_buf_get_name(0)
  if name == "" then
    return vim.loop.cwd()
  end
  -- If buffer is a directory, use it; if it's a file, use its parent
  local stat = vim.loop.fs_stat(name)
  if stat and stat.type == "directory" then
    return name
  end
  return vim.fn.fnamemodify(name, ":p:h")
end

local function open_in_explorer()
  local path = get_dir_under_cursor_or_buf()

  -- Prefer Thunar on your Hyprland setup, with graceful fallback
  if vim.fn.executable("thunar") == 1 then
    vim.fn.jobstart({ "thunar", path }, { detach = true })
    return
  end

  -- Neovim 0.10+: vim.ui.open does the right thing (xdg-open/open/start)
  if vim.ui and vim.ui.open then
    vim.ui.open(path)
    return
  end

  -- Fallbacks for older builds / odd environments
  if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.fn.jobstart({ "cmd.exe", "/C", "start", "", path }, { detach = true })
  elseif vim.fn.has("mac") == 1 then
    vim.fn.jobstart({ "open", path }, { detach = true })
  elseif vim.fn.has("wsl") == 1 and vim.fn.executable("wslview") == 1 then
    vim.fn.jobstart({ "wslview", path }, { detach = true })
  else
    vim.fn.jobstart({ "xdg-open", path }, { detach = true })
  end
end

-- Keymaps
vim.keymap.set("n", "<leader>e", open_in_explorer, { desc = "Open system file manager here" })

-- Nice: make it available inside Oil buffers, too
vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    vim.keymap.set("n", "go", open_in_explorer, { buffer = true, desc = "Open folder in system file manager" })
  end,
})

return {}
