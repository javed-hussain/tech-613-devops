# Environment Variables & Configuration — Concise Notes

Environment variables are named settings provided by the operating system or shell to a running program. In Python, you read them through `os.environ`, which behaves like a dictionary of string keys and string values.

They are useful for configuration that changes between machines or environments, such as timeouts, file paths, deployment environments, and secrets.

## Reading environment variables

```python
import os

print(os.environ.get("PATH", "not set")[:40])
print(os.environ.get("DEFINITELY_NOT_SET", "not set"))
```

| Expression | Meaning |
|---|---|
| `os.environ` | Dictionary-like mapping of environment variables |
| `os.environ["NAME"]` | Reads a required variable; raises `KeyError` if missing |
| `os.environ.get("NAME")` | Reads an optional variable; returns `None` if missing |
| `os.environ.get("NAME", "default")` | Reads an optional variable with a fallback value |
| `os.getenv("NAME", "default")` | Same practical behaviour as `os.environ.get()` |

Environment-variable values are always strings, even if they look like numbers.

## Setting a variable in Python

```python
os.environ["CHECK_TIMEOUT"] = "10"
```

- This changes the environment for the **current Python process**.
- It also affects child processes started by that Python process.
- It does **not** change the shell or other already-running programs.

## Setting a variable in the shell

```bash
CHECK_TIMEOUT=10 python3 script.py
```

Sets `CHECK_TIMEOUT` only for that one command.

```bash
export CHECK_TIMEOUT=10
python3 script.py
```

Makes it available to every command run from that shell session.

## Converting values

Environment variables are strings, so convert them before using them as numbers:

```python
raw = os.getenv("CHECK_TIMEOUT", "2")

try:
    timeout = int(raw)
except ValueError:
    raise SystemExit(f"CHECK_TIMEOUT must be a number, got {raw!r}")
```

- `int(raw)` converts `"2"` to `2`.
- `type(timeout).__name__` returns `"int"`.
- `{raw!r}` shows the original value with quotes, which makes error messages clearer.

## Configuration precedence

A robust program should decide which configuration source wins. Usually, the most specific source should take priority:

1. Command-line argument
2. Environment variable
3. Config file
4. Built-in default

```python
import os

CONFIG = {"timeout": 2}
DEFAULT = 1

def resolve_timeout(cli_value=None):
    if cli_value is not None:
        return cli_value, "command line"

    if "CHECK_TIMEOUT" in os.environ:
        return int(os.environ["CHECK_TIMEOUT"]), "environment"

    if "timeout" in CONFIG:
        return CONFIG["timeout"], "config file"

    return DEFAULT, "built-in default"
```

| Call | Result | Source |
|---|---|---|
| `resolve_timeout(9)` | `9` | Command line |
| `resolve_timeout()` with `CHECK_TIMEOUT=7` | `7` | Environment |
| `resolve_timeout()` with no environment variable | `2` | Config file |
| No config entry either | `1` | Built-in default |

## Secrets

Never store secrets directly in source code, Git commits, or Git history.

```python
# Never do this
WEBHOOK = "https://hooks.example.com/services/T00/B00/XXXXXXXXXXXXXXXX"
```

Even if you delete the line later, it may remain in Git history.

Instead, store the secret outside the code and read it at runtime:

```python
WEBHOOK = os.environ.get("HEALTHCHECK_WEBHOOK_URL")

if WEBHOOK:
    print("would post an alert to the configured webhook")
else:
    print("no webhook configured, skipping alerts")
```

## Secrets checklist

| Do | Do not |
|---|---|
| Store secrets in environment variables or a secrets manager | Put secrets in Python source files |
| Add `.env` to `.gitignore` | Commit `.env` files to Git |
| Use different secrets per environment | Reuse production secrets in development |
| Rotate exposed credentials immediately | Assume deleting a file removes it from Git history |

## Useful commands

| Command | Meaning |
|---|---|
| `os.environ` | Access all environment variables |
| `os.environ["NAME"]` | Read a required variable |
| `os.environ.get("NAME", default)` | Read an optional variable with fallback |
| `os.getenv("NAME", default)` | Alternative way to read an optional variable |
| `os.environ["NAME"] = value` | Set a variable for the current Python process |
| `VAR=value python3 script.py` | Set a variable for one shell command |
| `export VAR=value` | Set a variable for the current shell session |
| `unset VAR` | Remove a variable from the current shell session |
| `int(value)` | Convert a string environment value to an integer |
| `type(value).__name__` | Get the type name of a value |

## Key rule

Use environment variables for configuration and secrets, validate their values before use, and give command-line arguments the highest priority when both are available.
