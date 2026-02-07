require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Compilar LaTeX + abrir Skim
map("n", "<leader>l", function()
  vim.cmd "write"

  local file = vim.fn.expand "%"
  local pdf = vim.fn.expand "%:r" .. ".pdf"

  vim.fn.jobstart({ "lualatex", "-interaction=nonstopmode", file }, {
    stdout_buffered = true,
    stderr_buffered = true,

    on_exit = function(_, code)
      if code == 0 then
        vim.fn.jobstart { "open", "-a", "Skim", pdf }
      else
        print "Erro ao compilar LaTeX"
      end
    end,
  })
end, { desc = "Compilar LaTeX" })
