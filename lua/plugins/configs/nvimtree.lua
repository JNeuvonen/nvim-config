local options = {
  filters = {
    dotfiles = false,
    exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
  },
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = false,
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
  view = {
    adaptive_size = false,
    side = "left",
    width = 30,
    preserve_window_proportions = true,
  },
  git = {
    enable = false,
    ignore = false,
  },
  filesystem_watchers = {
    enable = true,
  },
  actions = {
    open_file = {
      resize_window = true,
    },
  },
  renderer = {
    root_folder_label = false,
    highlight_git = false,
    highlight_opened_files = "none",
    indent_markers = {
      enable = false,
    },
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = false,
      },
      glyphs = {
        default = "󰈚",
        symlink = "",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
          symlink_open = "",
          arrow_open = "",
          arrow_closed = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
}
require("nvim-tree").setup(options)
local function toggle_gitignore_filter()
  require("nvim-tree.api").tree.toggle_gitignore_filter()
end
local function increase_tree_width()
  local view = require "nvim-tree.view"
  if view.is_visible() then
    local current_width = view.View.width
    local new_width = current_width + 10
    vim.cmd("NvimTreeResize " .. new_width)
  else
    print "NvimTree is not open"
  end
end
local function decrease_tree_width()
  local view = require "nvim-tree.view"
  if view.is_visible() then
    local current_width = view.View.width
    local new_width = current_width - 10
    if new_width > 0 then
      vim.cmd("NvimTreeResize " .. new_width)
    else
      print "NvimTree width cannot be reduced further"
    end
  else
    print "NvimTree is not open"
  end
end
local function reset_tree_width()
  local view = require "nvim-tree.view"
  if view.is_visible() then
    local default_width = 30
    vim.cmd("NvimTreeResize " .. default_width)
  else
    print "NvimTree is not open"
  end
end
local function setup_keybindings()
  vim.api.nvim_set_keymap("n", "<leader>ti", "Increase NvimTree size", {
    noremap = true,
    silent = true,
    callback = increase_tree_width,
  })
  vim.api.nvim_set_keymap("n", "<leader>tr", "Reduce NvimTree size", {
    noremap = true,
    silent = true,
    callback = decrease_tree_width,
  })
  vim.api.nvim_set_keymap("n", "<leader>tR", "Make NvimTree default size", {
    noremap = true,
    silent = true,
    callback = reset_tree_width,
  })
  vim.api.nvim_set_keymap("n", "<leader>tg", "Toggle show/hide git ignored files", {
    noremap = true,
    silent = true,
    callback = toggle_gitignore_filter,
  })
end
local wk = require "which-key"
wk.register {
  ["<leader>"] = {
    t = {
      name = "NvimTree", -- group name for all NvimTree related keybindings
      i = { increase_tree_width, "Increase NvimTree size" },
      r = { decrease_tree_width, "Reduce NvimTree size" },
      R = { reset_tree_width, "Make NvimTree default size" },
      g = { toggle_gitignore_filter, "Toggle show/hide git ignored files" },
    },
  },
}
setup_keybindings()
return options
