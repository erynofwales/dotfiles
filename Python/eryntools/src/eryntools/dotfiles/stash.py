#!/usr/bin/env python3
# Eryn Wells <eryn@erynwells.me>

import json
import os
import os.path
from typing import Any, Iterable, Optional, TextIO, Union


class Dotfile:
    '''A single dotfile'''

    _DEFAULT_PREFIX = '.'

    @classmethod
    def from_json_object(cls, json_object: dict) -> 'Dotfile':
        return Dotfile(
            json_object['path'],
            prefix=json_object.get('prefix')
        )

    def __init__(self, path: str, *, prefix: Optional[str] = None):
        self.path = path
        self.prefix = prefix if prefix is not None else Dotfile._DEFAULT_PREFIX

    @property
    def destination_subpath(self) -> str:
        return f'{self.prefix}{self.path}'

    def source_path(self, root: Optional[str] = None) -> str:
        return os.path.join(root or '.', self.path)

    def destination_path(self, root: Optional[str] = None) -> str:
        return os.path.join(root or '~', self.destination_subpath)

    def link(self, source_root, destination_root, *, quiet: bool = True):
        source_path = self.source_path(source_root)
        destination_path = self.destination_path(destination_root)

        if not quiet:
            print(f'    · {source_path} → {destination_path}')

        # TODO: Perform the link
        pass

    def __repr__(self) -> str:
        return f'{self.__class__.__name__}({self.path})'

    def __str__(self) -> str:
        return f'{self.path} → {self.destination_subpath}'


class DotfileSet:
    '''A collection of dotfiles that are linked or unlinked as a group.'''

    @classmethod
    def from_json_object(cls, json_object: dict) -> 'DotfileSet':
        return DotfileSet(json_object['name'], map(Dotfile.from_json_object, json_object['files']))

    def __init__(self, name: str, dotfiles: Optional[Iterable[Union[Dotfile, str]]] = None):
        self.name = name

        def __convert(item: Union[Dotfile, str]) -> Dotfile:
            if isinstance(item, Dotfile):
                return item
            elif isinstance(item, str):
                return Dotfile(item)
            else:
                raise TypeError(f'Invalid type for dotfile: {item.__class__.__name__}')

        self.dotfiles: set[Dotfile] = set(__convert(i) for i in (dotfiles or []))

    def add(self, dotfile: Dotfile):
        self.dotfiles.add(dotfile)

    def link(
        self,
        source_root: Optional[str] = None,
        destination_root: Optional[str] = None,
        *,
        quiet: bool = True
    ):
        if not quiet and self.dotfiles:
            print(f"Linking ‘{self.name}’ dotfiles:")

        for dotfile in self.dotfiles:
            dotfile.link(source_root, destination_root, quiet=quiet)

    def __str__(self) -> str:
        if self.dotfiles:
            s = f'Dotfile set ‘{self.name}’:'
            for dotfile in self.dotfiles:
                s += f'\n  · {dotfile}'

            return s
        else:
            return f'Empty dotfile set ‘{self.name}’'


class Stash:
    @classmethod
    def load(cls, file: TextIO) -> 'Stash':
        stash_object: dict[str, Any] = json.load(file)

        stash = Stash()
        for set_object in stash_object['sets']:
            set = DotfileSet.from_json_object(set_object)
            stash.add(set.name, set)

        return stash

    def __init__(self):
        self.sets: dict[str, DotfileSet] = {}

    def add(self, name: str, set: DotfileSet):
        self.sets[name] = set

    def __str__(self):
        return '\n'.join(map(str, self.sets.values()))

