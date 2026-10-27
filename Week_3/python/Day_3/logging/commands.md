# Python `logging` — Command Reference

Logging records what a program is doing while it runs — especially important events, warnings, and errors — in a structured, timestamped way. Python’s built-in `logging` module replaces scattered `print()` statements by adding metadata such as time, severity level, source logger name, and message.

## All commands and arguments

| Command / expression | Arguments | Meaning |
|---|---|---|
| `import logging` | — | Imports Python’s built-in logging module |
| `logging.getLogger(name)` | `name`: logger name, e.g. `"deploy"` | Creates or retrieves a named logger |
| `logging.getLogger()` | No argument | Gets the root logger |
| `logging.basicConfig(**kwargs)` | See configuration options below | Configures the root logger |
| `logging.StreamHandler(stream=None)` | `stream`: output stream; defaults to `sys.stderr` | Creates a handler that sends logs to the terminal |
| `logging.FileHandler(filename, mode="a", encoding=None)` | `filename`: log file path; `mode`: `"a"` append or `"w"` overwrite; `encoding`: text encoding | Creates a handler that writes logs to a file |
| `handler.setLevel(level)` | `level`: e.g. `logging.DEBUG`, `logging.INFO` | Sets the minimum level the handler accepts |
| `logger.setLevel(level)` | `level`: e.g. `logging.DEBUG`, `logging.INFO` | Sets the minimum level the logger accepts |
| `log.debug(message)` | `message`: text or formatted string | Logs diagnostic detail |
| `log.info(message)` | `message`: text or formatted string | Logs normal progress |
| `log.warning(message)` | `message`: text or formatted string | Logs a problem that does not stop the program |
| `log.error(message)` | `message`: text or formatted string | Logs a failure |
| `log.critical(message)` | `message`: text or formatted string | Logs a severe failure |
| `log.exception(message)` | `message`: text or formatted string | Logs at `ERROR` level and includes the current traceback |
| `log.disabled = True` | `True` or `False` | Disables or enables a logger |
| `logging.disable(level)` | `level`: e.g. `logging.INFO` | Disables messages at that level and below |
| `path.read_text(encoding="utf-8")` | `encoding`: text encoding | Reads the log file for inspection |

## `logging.basicConfig()` arguments

| Argument | Example | Meaning |
|---|---|---|
| `level` | `level=logging.DEBUG` | Minimum level accepted by the root logger |
| `format` | `format="%(asctime)s %(levelname)-8s %(name)s: %(message)s"` | Layout of each log line |
| `datefmt` | `datefmt="%H:%M:%S"` | Time format |
| `handlers` | `handlers=[console, to_file]` | Destinations that receive accepted log records |
| `filename` | `filename="app.log"` | Shortcut: writes logs to this file |
| `filemode` | `filemode="a"` | `"a"` appends to the file; `"w"` overwrites it |
| `encoding` | `encoding="utf-8"` | Text encoding for the log file |
| `style` | `style="%"` | Formatting style: `"%"`, `"{"`, or `"$"` |

## Handler arguments

| Handler | Argument | Meaning |
|---|---|---|
| `StreamHandler(stream=None)` | `stream` | Where to write logs; defaults to `sys.stderr` |
| `FileHandler(filename)` | `filename` | Path of the log file |
| `FileHandler(filename, mode="a")` | `mode` | `"a"` appends; `"w"` overwrites |
| `FileHandler(filename, encoding="utf-8")` | `encoding` | Character encoding for the file |
| `handler.setLevel(level)` | `level` | Minimum level that handler accepts |

## Log-message arguments

| Method | Arguments | Level |
|---|---|---|
| `log.debug(message)` | `message` | `DEBUG` |
| `log.info(message)` | `message` | `INFO` |
| `log.warning(message)` | `message` | `WARNING` |
| `log.error(message)` | `message` | `ERROR` |
| `log.critical(message)` | `message` | `CRITICAL` |
| `log.exception(message)` | `message` | `ERROR`, plus traceback |

You can also use lazy `%` formatting:

```python
log.warning("Health check attempt %d/%d failed: HTTP %s", attempt, limit, status)
```

This is useful because the message is only formatted if the log record is actually emitted.

## Format placeholders

| Placeholder | Meaning |
|---|---|
| `%(asctime)s` | Human-readable timestamp |
| `%(levelname)s` | Log level name, e.g. `INFO` |
| `%(levelname)-8s` | Level name padded to at least 8 characters |
| `%(name)s` | Logger name |
| `%(message)s` | The log message |
| `%(lineno)d` | Line number where the logging call occurred |
| `%(funcName)s` | Function containing the logging call |
| `%(module)s` | Module where the logging call occurred |

## Log levels

| Level | Numeric value | Use for |
|---|---:|---|
| `logging.DEBUG` | 10 | Detailed diagnostic information |
| `logging.INFO` | 20 | Normal progress |
| `logging.WARNING` | 30 | Something unexpected, but the program continues |
| `logging.ERROR` | 40 | A failure that prevented an action |
| `logging.CRITICAL` | 50 | A severe failure; the service is unusable |

## Example

```python
import logging
from pathlib import Path

log_file = Path("deploy.log")

console = logging.StreamHandler()
console.setLevel(logging.INFO)

to_file = logging.FileHandler(log_file, encoding="utf-8")
to_file.setLevel(logging.DEBUG)

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s %(levelname)-8s %(name)s: %(message)s",
    datefmt="%H:%M:%S",
    handlers=[console, to_file],
)

log = logging.getLogger("deploy")

log.debug("Copying releases/v2 to app/current")
log.info("Backed up current release")
log.warning("Health check attempt %d/%d failed: HTTP %s", 1, 5, 500)
log.error("Health check failed after 5 attempts")
```
