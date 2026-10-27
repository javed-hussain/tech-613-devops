# Python `subprocess` — Concise Notes

`subprocess` lets Python start and control another program. It is essentially like running an external terminal command from inside Python, but with the command’s exit code, standard output, and error output available to your script.

Use it when your Python program needs to run another executable, such as `git`, `ls`, `rsync`, or another Python script.

## Running a command

```python
import subprocess
import sys

result = subprocess.run(
    [sys.executable, "--version"],
    capture_output=True,
    text=True,
)
```

- `subprocess.run()` starts the command, waits for it to finish, and returns a `CompletedProcess` object.
- The first argument is the command to run.
- `sys.executable` is the full path to the currently running Python interpreter.
- `capture_output=True` captures stdout and stderr instead of sending them straight to the terminal.
- `text=True` returns output as text rather than bytes.

## Inspecting the result

```python
print(result.returncode)
print(result.stdout.strip())
```

| Attribute | Meaning |
|---|---|
| `result.returncode` | Exit status of the command; `0` usually means success |
| `result.stdout` | Standard output from the command |
| `result.stderr` | Error output from the command |
| `result.args` | The command that was run |

Example:

```python
result = subprocess.run(
    [sys.executable, "--version"],
    capture_output=True,
    text=True,
)

print(result.returncode)      # 0
print(result.stdout.strip())  # Python 3.x.x
```

## Commands as lists

Pass the command and its arguments as a list:

```python
subprocess.run(["git", "status"])
subprocess.run(["ls", "-l"])
```

- The first item is the executable.
- The remaining items are arguments to that executable.
- `["git", "status"]` runs `git status`.
- `["git status"]` would look for an executable literally named `git status`, which does not exist.

## `shell=True`

```python
subprocess.run("ls ~", shell=True)
```

- `shell=True` makes the shell interpret the whole command string.
- It enables shell features such as `~` expansion, wildcards, and pipes.
- Avoid `shell=True` with untrusted user input because it can allow shell injection.

| Style | Example | Safer? |
|---|---|---|
| List form | `subprocess.run(["ls", "-l"])` | Preferred |
| Shell string | `subprocess.run("ls ~", shell=True)` | Only when necessary |

## Handling failures

When a command fails, you have three main options:

1. Ignore it — generally not recommended.
2. Handle it yourself — inspect `returncode` and decide what to do.
3. Raise an exception — use `check=True` when failure must stop the program.

### Raise an exception

```python
try:
    subprocess.run(
        [sys.executable, "-c", "import sys; sys.exit(1)"],
        capture_output=True,
        text=True,
        check=True,
    )
except subprocess.CalledProcessError as error:
    print(f"raised: return code {error.returncode}")
```

- `check=True` tells `subprocess.run()` to raise an exception if the return code is not `0`.
- `subprocess.CalledProcessError` contains details of the failed command.
- `error.returncode` gives the command’s exit status.

### Handle it yourself

```python
result = subprocess.run(
    [sys.executable, "-c", "import sys; sys.exit(1)"],
    capture_output=True,
    text=True,
    check=False,
)

print(f"returncode: {result.returncode}")

if result.returncode != 0:
    print("that command failed")
```

- `check=False` is the default: a non-zero exit code does not raise an exception.
- Check `result.returncode` yourself when failure is expected or recoverable.

## Timeouts

```python
try:
    subprocess.run(
        [sys.executable, "-c", "import time; time.sleep(10)"],
        timeout=1,
    )
except subprocess.TimeoutExpired:
    print("gave up after 1 second")
```

- `timeout=1` gives the command one second to finish.
- If it takes longer, Python raises `subprocess.TimeoutExpired`.
- Use timeouts for commands that might hang, such as network operations or health checks.

## Common patterns

| Task | Command |
|---|---|
| Run a command | `subprocess.run(["git", "status"])` |
| Capture output | Add `capture_output=True` |
| Get text instead of bytes | Add `text=True` |
| Fail on non-zero exit | Add `check=True` |
| Handle failure manually | Use `check=False`, then inspect `result.returncode` |
| Prevent hanging | Add `timeout=seconds` |
| Run the current Python interpreter | Use `sys.executable` |

## Key rule

Prefer `subprocess.run(["command", "arg1", "arg2"], capture_output=True, text=True)`. Use `check=True` when a failure should raise an exception, and use a `timeout` when a command might hang.
