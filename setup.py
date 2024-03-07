#!/usr/bin/env python3
# Eryn Wells <eryn@erynwells.me>

import argparse
import json
import os.path
import sys
from eryntools import scripting, dotfiles
from eryntools.dotfiles import stash
from typing import Optional


def dotfiles_json_path(dotfiles_path) -> Optional[str]:
    candidate_path = os.path.join(dotfiles_path, 'dotfiles_stash.json')
    if not os.path.isfile(candidate_path):
        return None
    return candidate_path


def parse_arguments(argv):
    parser = argparse.ArgumentParser(prog=argv[0])
    parser.add_argument(
        '-a', '--all',
        dest='link_all_sets',
        action='store_true',
        help='Link all sets in the configuration file')
    parser.add_argument('-c', '--config')
    parser.add_argument('-d', dest='dotfiles_path', default=dotfiles.find_repository())
    parser.add_argument('sets', nargs='*', metavar='SET')
    return parser, parser.parse_args(argv[1:])


def main(argv):
    _, arguments = parse_arguments(argv)

    print('Script path:', scripting.absolute_script_path())

    dotfiles_path = arguments.dotfiles_path
    if not dotfiles_path:
        raise RuntimeError("Couldn't find dotfiles repository")

    print('Dotfiles path:', dotfiles_path)

    stash_configuration_file_path = dotfiles_json_path(dotfiles_path)
    if not stash_configuration_file_path:
        raise RuntimeError("Couldn't find dotfiles stash configuration")

    with open(stash_configuration_file_path) as f:
        stash = dotfiles.stash.Stash.load(f)

    destination_root = '~'

    print()
    print(stash)


if __name__ == '__main__':
    try:
        sys.exit(main(sys.argv) or 0)
    except Exception as e:
        print('Error:', str(e), file=sys.stderr)
        sys.exit(-1)
