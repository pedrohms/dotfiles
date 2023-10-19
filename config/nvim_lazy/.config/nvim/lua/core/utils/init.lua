local M = {}

local requirePath = function(path, p)
  local files = io.popen('find ' .. path .. ' -type f')
  local plugins = p or {}
  if files then
    for file in files:lines() do
      local req_file = file:gmatch('%/lua%/(.+).lua$') { 0 }:gsub('/', '.')
      local status_ok, loaded = pcall(require, req_file)

      if not status_ok then
        vim.notify('Failed loading ' .. req_file, vim.log.levels.ERROR)
      else
        if type(loaded) == "table" then
          local exists = false
          for _, v in pairs(plugins) do
            if type(v) == "table" then
              if v[1] == loaded[1] then
                exists = true
                break
              end
            end
          end
          if not exists then
            table.insert(plugins,loaded)
          end
        end
      end
    end
  end
  return plugins
end

local requireNvimPath = function(path, p)
  return requirePath(os.getenv("HOME") .. "/.config/nvim/lua/" .. path, p)
end

M.requirePath = requirePath
M.requireNvimPath = requireNvimPath

return M
