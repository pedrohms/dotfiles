return {
  'kiddos/gemini.nvim',
  config = function()
    require('gemini').setup({
      model = 'gemini-2.0-flash'
    })
    vim.keymap.set("v", "<leader>gt", function()
      -- Pega o conteúdo da seleção visual
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local lines = vim.fn.getline(start_pos[2], end_pos[2])
      -- Ajusta o primeiro e último linha se necessário
      lines[1] = string.sub(lines[1], start_pos[3])
      lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

      local selected_text = table.concat(lines, "\n")
      vim.ui.input({ prompt = "Tarefa do código selecionado: " }, function(input)
        if input then
          input = selected_text:gsub('"', '\\"')
          vim.cmd("GeminiTask Com base no código:" .. selected_text .. " " .. input)
        end
      end)
    end)
    vim.keymap.set("n", "<leader>gt", function()
      vim.ui.input({ prompt = "Tarefa: " }, function(input)
        if input then
          vim.cmd("GeminiTask " .. input)
        end
      end)
    end, { desc = "Perguntar ao Gemini via prompt" })
    vim.keymap.set("n", "<leader>gp", function()
      vim.ui.input({ prompt = "Pergunte ao Gemini: " }, function(input)
        if input then
          vim.cmd("GeminiChat " .. input)
        end
      end)
    end, { desc = "Perguntar ao Gemini via prompt" })
    vim.keymap.set( { "v", "x" }, "<leader>gp", function()
      -- Pega o conteúdo da seleção visual
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local lines = vim.fn.getline(start_pos[2], end_pos[2])
      -- Ajusta o primeiro e último linha se necessário
      lines[1] = string.sub(lines[1], start_pos[3])
      lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])

      local selected_text = table.concat(lines, "\n")
      vim.ui.input({ prompt = "Pergunte ao gemini do código selecionado: " }, function(input)
        if input then
          input = vim.fn.shellescape(selected_text, true)
          vim.cmd("GeminiChat Com base no código: " .. selected_text .. " " .. input)
        end
      end)
    end)
  end
}
