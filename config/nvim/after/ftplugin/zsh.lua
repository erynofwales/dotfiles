-- Eryn Wells <eryn@erynwells.me>

local zshFPath = vim.env.FPATH
if zshFPath then
    local paths = vim.split(zshFPath, ":")
    vim.bo.path = ".," .. table.concat(paths, ",") .. ",,"
else
    local defaultFPath = {
        "~/.dotfiles/zsh/func/**",
        "~/.zsh/func/**",
        "/usr/local/share/zsh/site-functions",
        "/usr/share/zsh/site-functions"
    }
    vim.bo.path = ".," .. table.concat(defaultFPath) .. ",,"
end
