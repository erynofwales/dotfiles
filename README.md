Dotfiles
========

This is my collection of dotfiles, preserved here for all to see and enjoy. Feel
free to copy anything you see here. It would be nice if you added a comment
mentioning where you got it.

My environment relies on `zsh`, `vim`, and `git`.

## Installation

Clone the repository to a directory on your machine. I like to use
`~/.dotfiles`.

```sh
git clone https://github.com/erynofwales/dotfiles.git ~/.dotfiles
```

Run the setup script.

```sh
cd ~/.dotfiles
./setup.sh
```

This script will symlink all the config files in the directory to your home
directory, clone a bunch of git repos, and do some other miscellaneous setup.

Enjoy.

## Profiling

ZSH has a built in profiler. If you're concerned about init times, place the
following at the top of `.zshenv`.

```zsh
zmodload zsh/zprof
```

Then, at the end of either `.zshrc` or `.zprofile`, call `zprof` to get the
results of the profiling session.

## License

Everything in this repository is licensed under the [Creative Commons
Attribution 3.0 Unported License][ccaul].

[ccaul]: http://creativecommons.org/licenses/by/3.0/
