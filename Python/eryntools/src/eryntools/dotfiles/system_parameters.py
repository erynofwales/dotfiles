# Eryn Wells <eryn@erynwells.me>

import json
import os.path
import subprocess
import sys
from typing import Any, Optional, TextIO, Union


ParameterValue = Union[str, int, float]
ParametersObject = dict[str, Any]


_PARAMETERS_FILE = "~/.config/eryn/system_parameters.json"


class SystemParameters:
    class _Keys:
        DATA = 'data'
        PARAMETERS = 'parameters'
        VALUE = 'value'

    def __init__(self):
        self._object: ParametersObject = {}

    @property
    def parameters(self) -> dict:
        if not self._object:
            return {}

        return self._object[SystemParameters._Keys.PARAMETERS]

    def load_from_file(self, input_file: TextIO):
        self._object = json.load(input_file)

    def write_to_file(self, file):
        json.dump(self._object, file, indent=4, cls=_JSONEncoder)

    def __dir__(self):
        return dir(self._object)

    def __getattr__(self, name: str) -> Optional[ParameterValue]:
        if not self._object:
            return None

        return self._object[SystemParameters._Keys.PARAMETERS][name][SystemParameters._Keys.VALUE]

    def __setattr__(self, name: str, value: 'Parameter'):
        if not isinstance(value, Parameter):
            super().__setattr__(name, value)
            return

        parameter_value: ParametersObject = {
            SystemParameters._Keys.VALUE: value.value,
        }

        additional_data = value.additional_data
        if additional_data:
            parameter_value[SystemParameters._Keys.DATA] = additional_data

        self._object[name] = parameter_value


class Parameter:
    @property
    def value(self) -> str:
        '''The value of this parameter.'''
        raise NotImplementedError()

    @property
    def additional_data(self) -> Optional[dict[str, ParametersObject]]:
        '''Optional additional data to include in the parameter structure.'''
        return None


class CommandParameter(Parameter):
    class _Keys:
        CODE = 'code'
        COMMAND = 'command'
        RESULT = 'result'
        STDOUT = 'stdout'
        STDERR = 'stderr'

    def __init__(self, command_arguments: list):
        self.command = command_arguments
        self.result: Optional[subprocess.CompletedProcess] = None

    @property
    def value(self) -> str:
        self()
        return self.standard_output.strip()

    @property
    def standard_output(self) -> str:
        if not self.result or not self.result.stdout:
            return ''

        return self.result.stdout.decode('utf-8')

    @property
    def standard_error(self) -> str:
        if not self.result or not self.result.stderr:
            return ''

        return self.result.stderr.decode('utf-8')

    @property
    def additional_data(self) -> Optional[dict]:
        self()
        assert self.result is not None

        obj = {
            CommandParameter._Keys.COMMAND: self.result.args,
            CommandParameter._Keys.RESULT: {
                CommandParameter._Keys.CODE: self.result.returncode,
            }
        }

        stdout = self.standard_output
        if stdout:
            obj[CommandParameter._Keys.RESULT][CommandParameter._Keys.STDOUT] = stdout.strip()

        stderr = self.standard_error
        if stderr:
            obj[CommandParameter._Keys.RESULT][CommandParameter._Keys.STDERR] = stderr.strip()

        return obj

    def __call__(self) -> 'CommandParameter':
        if not self.result:
            self.result = subprocess.run(
                self.command,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT
            )

        return self


class _JSONEncoder(json.JSONEncoder):
    def default(self, o: Any) -> Any:
        if isinstance(o, SystemParameters):
            return super().default(o._object)

        return super().default(o)


def main(argv) -> Optional[int]:
    import argparse

    parser = argparse.ArgumentParser(prog=argv[0])
    parser.add_argument(
        'parameters_file',
        default=os.path.abspath(os.path.expanduser(_PARAMETERS_FILE)),
        nargs='?',
    )
    parser.add_argument('name')
    arguments = parser.parse_args(argv[1:])

    parameters = SystemParameters()
    with open(arguments.parameters_file) as f:
        parameters.load_from_file(f)

    print(getattr(parameters, arguments.name))


if __name__ == '__main__':
    import sys
    sys.exit(main(sys.argv) or 0)
