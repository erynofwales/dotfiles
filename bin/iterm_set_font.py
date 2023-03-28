#!/usr/bin/env python3
# Eryn Wells <eryn@erynwells.me>

import argparse
import iterm2

def parse_args(argv, *a, **kw):
    parser = argparse.ArgumentParser(*a, **kw)
    parser.add_argument('font')
    args = parser.parse_args(argv)
    return args

def main(argv):
    args = parse_args(argv[1:], prog=argv[0])

    new_font = args.font
    print(f'Will attempt to set font to "{new_font}"')

    async def set_font(connection):
        profile = await iterm2.Profile.async_get_default(connection)
        if not profile:
            return

        print(f'Current normal font of "{profile.name}" profile is "{profile.normal_font}"')
        print(f'Setting normal font of "{profile.name}" profile to "{new_font}"')

        await profile.async_set_normal_font(new_font)

    iterm2.run_until_complete(set_font)

if __name__ == '__main__':
    import sys
    result = main(sys.argv)
    sys.exit(0 if not result else result)
