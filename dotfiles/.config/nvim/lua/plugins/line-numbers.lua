return {
  "shrynx/line-numbers.nvim",
  lazy = false,
  -- Load early
  priority = 800,
  -- Plugin options
  opts = {
    -- Show both relative and absolute line numbers
    mode = "both",
    -- Show relative numbers first, then absolute
    format = "abs_rel",
    -- End character after the numbers
    separator = "│",
  },
  -- Plugin configuration function
  config = function(_, opts)
    -- Load the module directly
    local line_numbers = require("line-numbers")
    line_numbers.setup(opts)

    -- Set up keymaps
    vim.keymap.set("n", "<leader>ln", ":LineNumberToggle<CR>", {
      silent = true,
      desc = "Toggle line number mode",
    })
  end,
}
