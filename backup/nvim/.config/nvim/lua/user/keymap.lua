local M = {}

function bind(op, outer_opts)
    outer_opts = outer_opts or { noremap = true }
    return function(lhs, rhs, opts)
        opts = vim.tbl_extend("force",
            outer_opts,
            opts or {}
        )
        vim.keymap.set(op, lhs, rhs, opts)
    end
end


function unbind(op)
    return function(lhs)
        vim.keymap.del(op, lhs, { buffer = true })
    end
end

M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

M.nunremap = unbind("n")
M.iunremap = unbind("i")
M.vunremap = unbind("v")
M.xunremap = unbind("x")

return M
