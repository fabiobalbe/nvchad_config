require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Compilar LaTeX + abrir Skim
map("n", "<leader>l", function()
  vim.cmd "write"

  local file = vim.fn.expand "%"
  local abs = vim.fn.expand "%:p"
  local dir = vim.fn.expand "%:p:h"
  local pdf = vim.fn.expand "%:p:r" .. ".pdf"
  local name = vim.fn.expand "%:t"

  if not name:match "%.tex$" then
    vim.notify("Abra um arquivo .tex primeiro", vim.log.levels.WARN)
    return
  end

  vim.notify("Compilando " .. name .. "…", vim.log.levels.INFO)

  vim.fn.jobstart({ "lualatex", "-interaction=nonstopmode", "-file-line-error", name }, {
    cwd = dir,
    stdout_buffered = true,
    stderr_buffered = true,
    env = (function()
      local tiny = vim.fn.expand "~/Library/TinyTeX/bin/universal-darwin"
      local path = tiny .. ":" .. (vim.env.PATH or "")
      return { PATH = path, HOME = vim.env.HOME }
    end)(),
    on_exit = function(_, code, _)
      vim.schedule(function()
        if code == 0 then
          vim.notify("PDF gerado: " .. pdf, vim.log.levels.INFO)
          vim.fn.jobstart({ "open", "-a", "Skim", pdf }, { detach = true })
        else
          local log = dir .. "/" .. vim.fn.expand "%:t:r" .. ".log"
          local msg = "Erro ao compilar LaTeX (exit " .. code .. ")"
          if vim.fn.filereadable(log) == 1 then
            local lines = vim.fn.readfile(log)
            local errors = {}
            for _, line in ipairs(lines) do
              if line:match "^!" or line:match "Error" or line:match "Emergency" or line:match "not found" then
                table.insert(errors, line)
                if #errors >= 8 then
                  break
                end
              end
            end
            if #errors > 0 then
              msg = msg .. "\n" .. table.concat(errors, "\n")
            end
            msg = msg .. "\nLog: " .. log
          end
          vim.notify(msg, vim.log.levels.ERROR)
        end
      end)
    end,
  })
end, { desc = "Compilar LaTeX" })

-- Fechar terminal com Ctrl + H
vim.keymap.set("t", "<C-h>", [[<C-\><C-n>:bd!<CR>]], { desc = "Fechar terminal" })
vim.keymap.set("n", "<C-h>", ":bd!<CR>", { desc = "Fechar buffer (terminal)" })
