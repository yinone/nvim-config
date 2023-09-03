local uv = vim.loop

function _G.log(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end

function _G.requirePlugin(name)
  local status_ok, plugin = pcall(require, name)
  if not status_ok then
    vim.notify(' 没有找到插件：' .. name)
    return nil
  end
  return plugin
end

function _G.lspCap()
  print(vim.inspect(vim.lsp.buf_get_clients()[1].resolved_capabilities))
end

local M = {}

function M.readFile(path, callback)
  uv.fs_open(
    path, 'r', 438, function(err, fd)
      assert(not err, err)
      uv.fs_fstat(
        fd, function(err, stat)
          assert(not err, err)
          uv.fs_read(
            fd, stat.size, 0, function(err, data)
              assert(not err, err)
              uv.fs_close(
                fd, function(err)
                  assert(not err, err)
                  return callback(data)
                end
              )
            end
          )
        end
      )
    end
  )
end

function M.readFileSync(path)
  local fd = assert(uv.fs_open(path, 'r', 438))
  local stat = assert(uv.fs_fstat(fd))
  local data = assert(uv.fs_read(fd, stat.size, 0))
  assert(uv.fs_close(fd))
  return data
end

function M.buf_set_keymap(...)
  vim.api.nvim_buf_set_keymap(bufnr, ...)
end

return M
