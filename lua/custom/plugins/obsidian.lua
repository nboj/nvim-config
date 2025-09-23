-- Open the currently viewed file in Obsidian
local function url_encode(s)
  return (s:gsub("([^%w%-_%.~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end))
end

local function open_in_obsidian()
  local file = vim.fn.expand("%:p")
  if file == "" or vim.fn.filereadable(file) == 0 then
    vim.notify("No readable file in this buffer.", vim.log.levels.WARN)
    return
  end

  -- Obsidian supports either ?path=... or ?vault=...&file=...
  -- Using path works if the file lives inside any of your vaults.
  local url = "obsidian://open?path=" .. url_encode(file)

  local cmd
  if vim.fn.has("macunix") == 1 then
    cmd = { "open", url }
  elseif vim.fn.has("win32") == 1 then
    cmd = { "cmd.exe", "/c", "start", "", url }
  else
    cmd = { "xdg-open", url }
  end

  vim.fn.jobstart(cmd, { detach = true })
end

-- your mapping (I'd suggest <leader>o instead of '<leader><o>')
vim.keymap.set("n", "<leader>o", open_in_obsidian, { desc = "Open in Obsidian" })
return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
    -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "main",
        path = "~/vaults/main",
      },
    },

    -- see below for full list of options 👇
  },
}
