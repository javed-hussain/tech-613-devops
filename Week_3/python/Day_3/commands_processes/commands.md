# Python `subprocess` — Command Reference

`subprocess` lets Python start and control another program. `subprocess.run()` starts a command, waits for it to finish, and returns a `CompletedProcess` result.

## All commands

| Command / expression | Arguments | Meaning |
|---|---|---|
| `import subprocess` | — | Imports Python’s subprocess module |
| `subprocess.run(args)` | `args`: command and arguments, usually a list | Runs a command, waits for it to finish, and returns a result |
| `subprocess.run(args, capture_output=True)` | `capture_output`: capture stdout and stderr | Stores command output in `result.stdout` and `result.stderr` |
| `subprocess.run(args, text=True)` | `text`: decode output as text | Returns `stdout` and `stderr` as strings rather than bytes |
| `subprocess.run(args, check=True)` | `check`: raise on failure | Raises `CalledProcessError` if the exit code is not `0` |
| `subprocess.run(args, check=False)` | `check`: do not raise on failure | Returns the result so you can inspect `returncode` yourself |
| `subprocess.run(args, timeout=n)` | `timeout`: maximum seconds to wait | Raises `TimeoutExpired` if the command runs too long |
| `subprocess.run(args, cwd=path)` | `cwd`: working directory | Runs the command in the specified directory |
| `subprocess.run(args, env=environment)` | `env`: environment-variable mapping | Uses the supplied environment for the child process |
| `subprocess.run(command, shell=True)` | `command`: shell command string | Runs the command through the shell; enables shell expansion |
| `result.returncode` | — | Exit status of the command; `0` usually means success |
| `result.stdout` | — | Standard output from the command |
| `result.stderr` | — | Error output from the command |
| `result.args` | — | The command and arguments that were run |
| `subprocess.CalledProcessError` | Raised by `check=True` | Exception raised when a command exits non-zero |
| `error.returncode` | — | Exit code from a `CalledProcessError` |
| `subprocess.TimeoutExpired` | Raised by `timeout` | Exception raised when a command exceeds its timeout |
| `sys.executable` | — | Full path to the currently running Python interpreter |

## `subprocess.run()` arguments

| Argument | Example | Meaning |
|---|---|---|
| `args` | `["git", "status"]` | Command to run and its arguments |
| `capture_output` | `capture_output=True` | Captures stdout and stderr |
| `text` | `text=True` | Returns output as text instead of bytes |
| `check` | `check=True` | Raises an exception on non-zero exit code |
| `timeout` | `timeout=10` | Maximum time in seconds to wait |
| `cwd` | `cwd="/tmp"` | Directory in which to run the command |
| `env` | `env={"KEY": "value"}` | Environment variables for the child process |
| `shell` | `shell=True` | Runs the command through the shell |
| `input` | `input="hello\n"` | Text or bytes sent to the command’s stdin |

## Result attributes

| Attribute | Meaning |
|---|---|
| `result.returncode` | Exit status; `0` usually means success |
| `result.stdout` | Standard output |
| `result.stderr` | Standard error |
| `result.args` | Command and arguments that were run |
| `result.check` | Whether `check=True` was used |
| `result.cwd` | Working directory used for the command |
| `result.timeout` | Timeout value used, if any |

## Exceptions

| Exception | Raised when | Common handling |
|---|---|---|
| `subprocess.CalledProcessError` | `check=True` and return code is non-zero | Inspect `error.returncode`, `error.stdout`, `error.stderr` |
| `subprocess.TimeoutExpired` | Command exceeds `timeout` | Retry, log, or give up |
| `FileNotFoundError` | Executable cannot be found | Check the command name or use `shutil.which()` |

## Command forms

| Form | Example | Notes |
|---|---|---|
| List form | `subprocess.run(["git", "status"])` | Preferred and safer |
| Shell string | `subprocess.run("git status", shell=True)` | Enables shell features; avoid with untrusted input |
| Current Python | `subprocess.run([sys.executable, "--version"])` | Uses the active Python interpreter |
| Python code string | `subprocess.run([sys.executable, "-c", "print('hi')"])` | Runs a short Python program |

## Common patterns

| Task | Command |
|---|---|
| Run a command | `subprocess.run(["git", "status"])` |
| Capture output | `subprocess.run(["git", "status"], capture_output=True)` |
| Get text output | Add `text=True` |
| Fail on error | Add `check=True` |
| Handle errors manually | Use `check=False`, then inspect `result.returncode` |
| Add a timeout | Add `timeout=10` |
| Run in another directory | Add `cwd="/path/to/dir"` |
| Run current Python | Use `sys.executable` |

## Example

```python
import subprocess
import sys

try:
    result = subprocess.run(
        [sys.executable, "--version"],
        capture_output=True,
        text=True,
        check=True,
        timeout=5,
    )

    print(result.returncode)
    print(result.stdout.strip())

except subprocess.CalledProcessError as error:
    print(f"Command failed with return code {error.returncode}")

except subprocess.TimeoutExpired:
    print("Command timed out")
```
