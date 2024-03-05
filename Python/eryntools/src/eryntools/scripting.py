# Eryn Wells <eryn@erynwells.me>

import os.path
import sys
from typing import Optional


def absolute_script_path(argv0: Optional[str] = None) -> Optional[str]:
    '''Get the absolute path to the currently executing script.'''
    executable = argv0 or sys.argv[0]
    return os.path.abspath(executable) if executable else None
