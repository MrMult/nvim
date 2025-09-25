local util = require('lspconfig.util')

local function get_project_root()
    local fname = vim.api.nvim_buf_get_name(0)

    -- Try to find git ancestor first
    local git_root = util.find_git_ancestor(fname)
    if git_root then
        return git_root
    end

    -- Then try to find solution or project files
    local root_patterns = { '*.sln', '*.csproj', '*.fsproj', '*.vbproj' }
    for _, pattern in ipairs(root_patterns) do
        local root = util.root_pattern(pattern)(fname)
        if root then
            return root
        end
    end

    -- Fallback to current file's directory
    return vim.fn.expand('%:p:h')
end

-- Create the main Dotnet command
vim.api.nvim_create_user_command('Dotnet', function(opts)
    local root_dir = get_project_root()
    local command = 'dotnet ' .. opts.args

    -- Save current directory, change to project root, execute command, then return
    local original_dir = vim.fn.getcwd()
    vim.cmd('cd ' .. vim.fn.fnameescape(root_dir))
    vim.cmd('!' .. command)
    vim.cmd('cd ' .. vim.fn.fnameescape(original_dir))
end, {
    nargs = '+',  -- Accept one or more arguments
    complete = function(ArgLead, CmdLine, CursorPos)
        -- Auto-completion for common dotnet commands
        local commands = {
            'build', 'run', 'test', 'clean', 'restore', 'new', 'add', 'remove',
            'pack', 'publish', 'nuget', 'sln', 'tool', 'dev-certs'
        }

        return vim.tbl_filter(function(cmd)
            return vim.startswith(cmd, ArgLead)
        end, commands)
    end,
    desc = 'Execute dotnet command in project root directory'
})


-- Convenience commands for common dotnet operations
local dotnet_commands = {
    Build = 'build',
    Run = 'run',
    Test = 'test',
    Clean = 'clean',
    Restore = 'restore',
    AddPackage = 'add package',
    New = 'new'
}

for cmd_name, cmd_args in pairs(dotnet_commands) do
    vim.api.nvim_create_user_command('Dotnet' .. cmd_name, function(opts)
        local full_command = cmd_args .. ' ' .. (opts.args or '')
        vim.cmd('Dotnet ' .. full_command)
    end, {
        nargs = '*',  -- Optional arguments
        desc = 'Dotnet ' .. cmd_args .. ' in project root'
    })
end

-- Key mappings for quick access
vim.keymap.set('n', '<leader>dn', ':Dotnet ', { desc = 'Dotnet command' })
vim.keymap.set('n', '<leader>db', ':DotnetBuild<CR>', { desc = 'Dotnet build' })
vim.keymap.set('n', '<leader>dr', ':DotnetRun<CR>', { desc = 'Dotnet run' })
vim.keymap.set('n', '<leader>dt', ':DotnetTest<CR>', { desc = 'Dotnet test' })
vim.keymap.set('n', '<leader>dc', ':DotnetClean<CR>', { desc = 'Dotnet clean' })

