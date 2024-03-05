# Eryn Wells <eryn@erynwells.me>

from os.path import expanduser, expandvars, isdir, join
from typing import Optional


def find_repository(path: Optional[str] = None) -> Optional[str]:
    '''Find the dotfiles repo.'''

    _DEFAULT_CANDIDATE_PATHS = [
        '~/.dotfiles',
    ]

    candidate_paths: list[str] = []
    if path:
        candidate_paths.append(path)
    candidate_paths.extend(_DEFAULT_CANDIDATE_PATHS)

    for path in candidate_paths:
        path = expanduser(path)
        path = expandvars(path)

        if not path_is_git_repository(path):
            continue

        return path

    return None


def path_is_git_repository(path: str) -> bool:
    return bool(path) and isdir(path) and isdir(join(path, '.git'))
