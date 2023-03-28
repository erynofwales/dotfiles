-- Eryn Wells <eryn@erynwells.me>

vim.cmd [[
    source ~/.vimrc.common
    source ~/.vim/plugins.vim 
]]

require 'os'

require 'configuration'
require 'colors'
require 'keys'

function ensureMetadataDirectoriesExist()
    local paths = {
        vim.opt.backupdir:get(),
        vim.opt.directory:get(),
        vim.opt.undodir:get(),
    }

    local function makeDirectory(path)
        os.execute("mkdir", "-p", path)
    end

    for _, opt in ipairs(paths) do
        for _, value in ipairs(opt) do
            if string.find(value, "//$") then
                makeDirectory(path)
            end
        end
    end

    -- The shadafile option is a single option but get() returns a table, so
    -- iterate it just to be safe.
    for _, opt in ipairs(vim.opt.shadafile:get()) do
        local shadaDirectory = vim.fs.dirname(opt)
        makeDirectory(shadaDirectory)
    end
end

ensureMetadataDirectoriesExist()
