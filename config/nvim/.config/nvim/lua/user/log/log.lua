local M = {}
function saveOnFile(message)
  local log_file_path = vim.fn.stdpath "data" .. "/meu_log.txt"
  if os.getenv("OS") ~= "Windows_NT" then
    log_file_path = os.getenv("HOME") .. "/vim_my_log"
  end
  local log_file = io.open(log_file_path, "a")
  io.output(log_file)
  io.write(message .. "\n")
  io.close(log_file)
end

M.inspect = function(message)
  saveOnFile(Vim.inspect(message))
end

M.println = function(message)
  saveOnFile(message)
end


return M
