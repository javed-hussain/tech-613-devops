# Python `argparse` — Concise Notes

`argparse` is Python’s standard-library module for turning command-line text into usable values in your script. You declare the arguments your program accepts, and `argparse` parses them, validates them, and generates `--help` automatically.

## Raw command-line arguments

Before using `argparse`, Python exposes the raw command line through `sys.argv`.

```python
import sys

argv = sys.argv

print(argv[0])   # script name or path
print(argv[1:])  # user-supplied arguments
```

`sys.argv` is a list:

```python
["deploy.py", "v2", "--dry-run"]
```

| Position | Value | Meaning |
|---|---|---|
| `argv[0]` | `deploy.py` | Script name or path |
| `argv[1]` | `v2` | First user argument |
| `argv[2]` | `--dry-run` | Second user argument |

Interpreter options such as `-c`, `-m`, or `-u` are generally not included in `sys.argv`.

## Manual parsing

You can parse `sys.argv` manually, but it becomes repetitive and error-prone:

```python
if len(argv) < 2:
    print("usage: deploy.py VERSION [--dry-run]")
else:
    version = argv[1]
    dry_run = "--dry-run" in argv
    print(f"version={version} dry_run={dry_run}")
```

- `argv[1]` is treated as the version.
- `"--dry-run" in argv` checks whether the flag was supplied.
- This approach does not automatically generate help or handle invalid input well.

`argparse` solves these problems.

## Creating a parser

```python
import argparse

parser = argparse.ArgumentParser(
    description="Deploy a release of flask-demo."
)
```

`ArgumentParser` is the object that stores the rules for your command-line interface.

- `description` appears at the top of `--help`.
- You add arguments with `parser.add_argument()`.
- You parse input with `parser.parse_args()`.

## Positional arguments

A positional argument is matched by its order on the command line.

```python
parser.add_argument(
    "version",
    help="the release to deploy, e.g. v2",
)
```

Command:

```bash
python3 deploy.py v2
```

Result:

```python
args.version  # "v2"
```

The first value after the script name becomes `args.version`.

## Parsing arguments

```python
args = parser.parse_args()
```

Without an argument, `parse_args()` reads the real command line from `sys.argv`.

For testing, you can pass a list manually:

```python
args = parser.parse_args(["v2"])
print(args.version)  # v2
```

`parse_args()`:

- Reads the arguments.
- Matches them against the rules you defined.
- Validates values and types.
- Applies defaults.
- Prints an error and exits if input is invalid.
- Returns a namespace object such as `args`.

## Accessing parsed values

The object returned by `parse_args()` stores each argument as an attribute.

```python
args = parser.parse_args(["v2"])
print(args.version)
```

The attribute name comes from the argument name:

| Argument definition | Attribute |
|---|---|
| `add_argument("version")` | `args.version` |
| `add_argument("--config")` | `args.config` |
| `add_argument("--dry-run")` | `args.dry_run` |
| `add_argument("--output-file")` | `args.output_file` |

Hyphens in option names become underscores in attribute names.

## Optional arguments

An optional argument starts with `--` and does not have to be supplied.

```python
parser.add_argument(
    "--config",
    default="deploy.yaml",
    help="path to the config file",
)
```

If `--config` is omitted:

```python
args.config  # "deploy.yaml"
```

If it is supplied:

```python
args = parser.parse_args(["v2", "--config", "staging.yaml"])
args.config  # "staging.yaml"
```

`--config` consumes the next value as its own value.

## Boolean flags

A simple on/off flag uses `action="store_true"`.

```python
parser.add_argument(
    "--dry-run",
    action="store_true",
    help="show what would happen without making changes",
)
```

| Command | `args.dry_run` |
|---|---|
| `python3 deploy.py v2` | `False` |
| `python3 deploy.py v2 --dry-run` | `True` |

A boolean flag does **not** consume the next argument.

## Value options versus flags

| Kind | Example | Takes a following value? |
|---|---|---|
| Positional argument | `v2` | Is itself a value |
| Value option | `--config staging.yaml` | Yes |
| Boolean flag | `--dry-run` | No |

For example:

```bash
python3 deploy.py v2 --dry-run --config staging.yaml
```

gives:

```python
args.version   # "v2"
args.dry_run   # True
args.config    # "staging.yaml"
```

## Useful `add_argument()` options

| Option | Purpose | Example |
|---|---|---|
| `help` | Documents the argument in `--help` | `help="path to config"` |
| `default` | Value used when the argument is omitted | `default="deploy.yaml"` |
| `type` | Converts the input value | `type=int` |
| `choices` | Restricts allowed values | `choices=["text", "json"]` |
| `nargs` | Controls how many values are accepted | `nargs="?"`, `nargs="*"` |
| `required` | Makes an optional argument required | `required=True` |
| `action` | Changes parsing behaviour | `action="store_true"` |
| `metavar` | Changes the placeholder shown in help | `metavar="FILE"` |
| `dest` | Changes the attribute name | `dest="config_path"` |

## Type conversion

```python
parser.add_argument("--port", type=int)
```

Command:

```bash
python3 app.py --port 8000
```

Result:

```python
args.port  # 8000, an int
```

If the value cannot be converted:

```bash
python3 app.py --port not-a-number
```

`argparse` prints an error and exits:

```text
argument --port: invalid int value: 'not-a-number'
```

## Error handling

`parse_args()` normally handles invalid input itself by printing a usage message and exiting.

```python
try:
    parser.parse_args(["--port", "not-a-number"])
except Exception as error:
    print(f"argparse exited with code {error}")
```

In a normal script, you usually do not need to catch this exception: argparse’s built-in behaviour is to show a helpful error and terminate with a non-zero exit code.

## Why use `argparse`?

| Manual `sys.argv` parsing | `argparse` |
|---|---|
| You check positions yourself | Arguments are matched by name or position |
| You convert types yourself | Use `type=int`, `type=float`, etc. |
| You write your own usage message | `--help` is generated automatically |
| Invalid input can fail silently | Invalid input produces clear errors |
| Defaults must be handled manually | Use `default=` |

## Key rule

Use `argparse` when your script accepts command-line input. Define the expected arguments with `add_argument()`, parse them with `parse_args()`, then access the values through attributes such as `args.version`, `args.config`, and `args.dry_run`.
