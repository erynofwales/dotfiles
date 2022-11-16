-- Eryn Wells <eryn@erynwells.me>

vim.opt.runtimepath:prepend "~/.vim"
vim.cmd [[ source ~/.vimrc.common ]]

require 'configuration'
require 'keys'

function ensureMetadataDirectoriesExist()
    paths = {
        vim.opt.backupdir:get(),
        vim.opt.directory:get(),
        vim.opt.undodir:get()
    }

    for _, opt in ipairs(paths) do
        local first_path = opt[1]
        if string.find(first_path, "//$") then
            os.execute("mkdir -p " .. first_path)
        end
    end
end

ensureMetadataDirectoriesExist()
