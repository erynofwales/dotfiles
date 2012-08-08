Dotfiles
========

This is my collection of dotfiles, preserved here for all to see and enjoy.
Feel free to copy anything you see here. It would be nice if you added a
comment mentioning where you got it.

My environment relies on `zsh`, `vim`, and `git`.

## Installation

Clone the repository to a directory on your machine. I like to use
`~/.dotfiles`.

    git clone https://github.com/erynofwales/dotfiles.git ~/.dotfiles

Run the setup script.

    cd ~/.dotfiles
    ./setup.sh

This script will symlink all the config files in the directory to your home
directory, clone a bunch of git repos, and do some other miscellaneous setup.

Enjoy.

## Shell Environment

As much as possible, I tried to keep these files as system agnostic as
possible. I work on lots of different systems so having the ability to bring
down my core environment and customize it is very useful. Most of the
environment files have three levels:

1. The main file (e.g. `.zshrc`).
2. A system specific file whose name is generated by the `uname -s` command.
   So, these files have names like `.zshrc.darwin` and `.env.linux`. The system
   name is exported as `$SYS` in the `.env` script.
3. A machine specific file whose name is derived by appending `.local` to the
   main file's name (e.g. `.zshrc.local`).

Files 2 and 3 are sourced at the end of the main file, so any settings you add
there will override those set in the main file.

## Loud Noises!

In a recent change I added some extra functions to print out status
messages as ZSH starts up. These are all defined in `shell-functions`
(symlinked to `~/.shell-functions` by the setup script). At any point in the
setup process, you can set the variable `$NOISY` to a number greater than 0 to
see extra status messages.

## License

Everything in this repository is licensed under the [Creative Commons
Attribution 3.0 Unported License][ccaul].

[ccaul]: http://creativecommons.org/licenses/by/3.0/
