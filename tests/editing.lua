-- Run in a fresh process: nvim --headless -i NONE -c "luafile tests/editing.lua"
vim.opt.completeopt = { "menu", "menuone", "noinsert", "noselect" }
local passed = 0
local scenarios = {
    {
        name = "selected completion acceptance",
        before = "tes",
        input = "A",
        popup = true,
        action = "<Tab><CR>",
        check = function(lines)
            return #lines == 1 and lines[1] == "testing"
        end,
    },
    {
        name = "paired newline",
        before = "{}",
        input = "a<CR>",
        check = function(lines)
            return #lines == 3 and lines[1] == "{" and lines[3] == "}"
        end,
    },
    {
        name = "paired parentheses deletion",
        before = "()",
        input = "a<BS>",
        check = function(lines)
            return #lines == 1 and lines[1] == ""
        end,
    },
    {
        name = "paired quotes deletion",
        before = '""',
        input = "a<BS>",
        check = function(lines)
            return #lines == 1 and lines[1] == ""
        end,
    },
    {
        name = "unselected completion newline",
        before = "tes",
        input = "A",
        popup = true,
        action = "<CR>",
        check = function(lines)
            return #lines == 2 and lines[1] == "tes" and not lines[2]:find "%S"
        end,
    },
    {
        name = "completion backspace",
        before = "tes",
        input = "A",
        popup = true,
        action = "<BS>",
        check = function(lines)
            return #lines == 1 and lines[1] == "te"
        end,
    },
}
local function finish(ok, err)
    if ok then
        io.stdout:write(string.format("Passed %d editing regression checks\n", passed))
        io.stdout:flush()
        vim.cmd "qa!"
    else
        vim.api.nvim_err_writeln(err)
        vim.cmd "cquit 1"
    end
end
local function guarded(fn)
    local ok, err = xpcall(fn, debug.traceback)
    if not ok then
        finish(false, err)
    end
end
vim.defer_fn(function()
    guarded(function()
        vim.api.nvim_set_current_buf(vim.api.nvim_create_buf(false, true))
        vim.bo.filetype = "lua"
        local index = 0
        local function next_case()
            guarded(function()
                index = index + 1
                local scenario = scenarios[index]
                if not scenario then
                    local right = vim.fn.maparg("<C-l>", "i", false, true)
                    local up = vim.fn.maparg("<C-k>", "i", false, true)
                    assert(right.rhs == "<Right>" and up.rhs == "<Up>", "COQ must preserve cursor movement mappings")
                    finish(true)
                    return
                end
                vim.api.nvim_input "<Esc>"
                vim.defer_fn(function()
                    guarded(function()
                        vim.api.nvim_buf_set_lines(0, 0, -1, false, { scenario.before })
                        vim.api.nvim_win_set_cursor(0, { 1, 0 })
                        vim.api.nvim_input(scenario.input)
                        vim.defer_fn(function()
                            guarded(function()
                                if scenario.popup then
                                    vim.fn.complete(1, { { word = "testing" }, { word = "tester" } })
                                    assert(vim.fn.complete_info({ "selected" }).selected == -1)
                                    vim.api.nvim_input(scenario.action)
                                end
                                vim.defer_fn(function()
                                    guarded(function()
                                        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                                        assert(scenario.check(lines), scenario.name .. ": " .. vim.inspect(lines))
                                        passed = passed + 1
                                        next_case()
                                    end)
                                end, 100)
                            end)
                        end, 100)
                    end)
                end, 100)
            end)
        end
        next_case()
    end)
end, 1500)
vim.defer_fn(function()
    finish(false, "timeout")
end, 10000)
