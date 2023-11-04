---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<leader>dq"] = { "<cmd>lua vim.diagnostic.setqflist()<CR>", "populate quickfix with diagnostics", opts = { noremap = true, silent = true } },
    ["<leader>dw"] = {
      "<cmd>lua vim.diagnostic.setloclist()<CR>",
      "populate quickfix with buffer diagnostics",
      opts = { noremap = true, silent = true },
    },
    ["<leader>qh"] = {
      function()
        require("nvterm.terminal").new "float"
      end,
      "New floating term",
    },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
}

M.dap = {
  plugin = true,
  n = {
    ["<leader>mp"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line",
    },
    ["<leader>dr"] = {
      "<cmd> DapContinue <CR>",
      "Start or continue the debugger",
    },
    ["<leader>dc"] = {
      "<Cmd>lua require'dap'.clear_breakpoints()<CR>",
      "Clear all breakpoints",
    },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require("dap-python").test_method()
      end,
    },
  },
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags",
    },
  },
}


-- more keybinds!

return M
