# Python `argparse` — Command Reference

`argparse` turns command-line text into usable Python values. You declare arguments with `add_argument()`, parse them with `parse_args()`, and access the results through attributes on the returned `args` object.

## All commands

| Command / expression | Arguments | Meaning |
|---|---|---|
| `import argparse` | — | Imports Python’s argparse module |
| `argparse.ArgumentParser(description=...)` | `description`: text shown at the top of `--help` | Creates a command-line parser |
| `parser.add_argument(name_or_flags, **options)` | Positional name or option flags, plus options such as `help`, `default`, `type` | Declares an argument the program accepts |
| `parser.parse_args()` | No argument | Reads the real command line from `sys.argv` |
| `parser.parse_args(argv)` | `argv`: list of argument strings | Parses a supplied list, useful for testing |
| `args.attribute` | Attribute name derived from the argument | Accesses a parsed value, e.g. `args.version` |
| `parser.print_help()` | No argument | Prints the generated help message |
| `parser.format_help()` | No argument | Returns the help message as a string |
| `parser.exit(status=0, message=None)` | `status`: exit code; `message`: optional text | Exits with an optional message |
| `parser.error(message)` | `message`: error text | Prints usage/error text and exits with status 2 |

## `add_argument()` options

| Option | Example | Meaning |
|---|---|---|
| Positional name | `"version"` | Required value matched by order |
| Option flag | `"--config"` | Optional named argument |
| Short flag | `"-c"` | Short alias for an option |
| `help` | `help="path to config"` | Help text shown in `--help` |
| `default` | `default="deploy.yaml"` | Value used when the option is omitted |
| `type` | `type=int` | Converts the input value |
| `choices` | `choices=["text", "json"]` | Restricts allowed values |
| `required` | `required=True` | Makes an optional argument required |
| `action` | `action="store_true"` | Changes parsing behaviour |
| `nargs` | `nargs="?"` | Controls how many values are accepted |
| `metavar` | `metavar="FILE"` | Placeholder name shown in help |
| `dest` | `dest="config_path"` | Changes the attribute name on `args` |

## Argument kinds

| Kind | Example definition | Example command | Result |
|---|---|---|---|
| Positional | `add_argument("version")` | `python3 app.py v2` | `args.version == "v2"` |
| Value option | `add_argument("--config")` | `python3 app.py --config staging.yaml` | `args.config == "staging.yaml"` |
| Boolean flag | `add_argument("--dry-run", action="store_true")` | `python3 app.py --dry-run` | `args.dry_run == True` |
| Option with choices | `add_argument("--format", choices=["text", "json"])` | `python3 app.py --format json` | `args.format == "json"` |
| Typed option | `add_argument("--port", type=int)` | `python3 app.py --port 8000` | `args.port == 8000` |

## `nargs` values

| `nargs` | Meaning | Result type |
|---|---|---|
| Omitted | Exactly one value | Single value |
| `"?"` | Zero or one value | Value or default |
| `"*"` | Zero or more values | List |
| `"+"` | One or more values | List |
| `2` | Exactly two values | List of two items |

## `action` values

| Action | Meaning | Result |
|---|---|---|
| `"store"` | Default: stores the supplied value | Value |
| `"store_true"` | Flag present means true | `True` or `False` |
| `"store_false"` | Flag present means false | `True` or `False` |
| `"append"` | Each occurrence is added to a list | List |
| `"count"` | Counts how many times a flag appears | Integer |
| `"help"` | Shows help and exits | Help text |

## Attribute naming

| Argument definition | Attribute |
|---|---|
| `add_argument("version")` | `args.version` |
| `add_argument("--config")` | `args.config` |
| `add_argument("--dry-run")` | `args.dry_run` |
| `add_argument("--output-file")` | `args.output_file` |
| `add_argument("--config", dest="config_path")` | `args.config_path` |

Hyphens in option names become underscores unless `dest` is specified.

## Example

```python
import argparse

parser = argparse.ArgumentParser(description="Deploy a release of flask-demo.")

parser.add_argument("version", help="release to deploy, e.g. v2")

parser.add_argument(
    "--config",
    default="deploy.yaml",
    help="path to the config file",
)

parser.add_argument(
    "--dry-run",
    action="store_true",
    help="validate and stop without making changes",
)

parser.add_argument(
    "--format",
    choices=["text", "json"],
    default="text",
    help="output format",
)

args = parser.parse_args()

print(args.version)
print(args.config)
print(args.dry_run)
print(args.format)
```

Example command:

```bash
python3 deploy.py v2 --config staging.yaml --dry-run --format json
```

Result:

```python
args.version  # "v2"
args.config   # "staging.yaml"
args.dry_run  # True
args.format   # "json"
```
