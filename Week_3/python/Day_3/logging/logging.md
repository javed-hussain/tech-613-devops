# Python `logging` 

Logging records what a program is doing while it runs — especially important events, warnings, and errors — in a structured, timestamped way. Python’s built-in `logging` module replaces scattered `print()` statements by adding useful metadata such as time, severity level, source logger name, and message.

A good log should tell a story: what happened, when it happened, how serious it was, and where it came from.

## Why logging beats `print()`

| Problem with `print()` | What it costs you |
|---|---|
| No timestamp | “Health check failed” — but when? Before or after the restart? |
| No level | Everything looks equally important, so nothing stands out |
| No source | Which function or component produced the message? |
| Only stdout | Cannot send detailed logs to a file and a summary to the terminal |

Logging adds metadata to each message, such as:

- Timestamp
- Severity level
- Logger name
- Message text

## Log levels

| Level | Use it for | Example |
|---|---|---|
| `DEBUG` | Detail useful when diagnosing a problem | `Copying releases/v2 to app/current` |
| `INFO` | Normal progress | `Backed up current release` |
| `WARNING` | Something is wrong, but the program can continue | `Health check attempt 1/5 failed` |
| `ERROR` | Something failed and the action could not complete | `Health check failed after 5 attempts` |
| `CRITICAL` | The whole application or service is unusable | `Rollback failed, service is down` |

## Basic setup

```python
import logging
from pathlib import Path

log_file = Path("deploy.log")
```

## Handlers

A handler decides **where** a log record goes.

| Handler | Purpose |
|---|---|
| `logging.StreamHandler()` | Sends log records to the terminal, normally stderr |
| `logging.FileHandler(path, encoding="utf-8")` | Writes log records to a file |

```python
console = logging.StreamHandler()
console.setLevel(logging.INFO)

to_file = logging.FileHandler(log_file, encoding="utf-8")
to_file.setLevel(logging.DEBUG)
```

- `console.setLevel(logging.INFO)` means the terminal receives `INFO` and above.
- `to_file.setLevel(logging.DEBUG)` means the file receives `DEBUG` and above.
- A handler level filters messages for that destination.

## Configuring the root logger

```python
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s %(levelname)-8s %(name)s: %(message)s",
    datefmt="%H:%M:%S",
    handlers=[console, to_file],
)
```

| Setting | Meaning |
|---|---|
| `level=logging.DEBUG` | Minimum level accepted by the root logger |
| `format=...` | Layout of each log line |
| `datefmt="%H:%M:%S"` | Time format, e.g. `14:32:08` |
| `handlers=[...]` | Destinations that receive accepted log records |

Format placeholders:

| Placeholder | Meaning |
|---|---|
| `%(asctime)s` | Human-readable timestamp |
| `%(levelname)-8s` | Level name, left-aligned in at least 8 characters |
| `%(name)s` | Logger name |
| `%(message)s` | The log message |

## Creating a named logger

```python
log = logging.getLogger("deploy")
```

- `getLogger("deploy")` creates or retrieves a logger named `deploy`.
- A named logger makes it clear which part of the program produced a message.
- Without a name, Python uses the root logger.

## Writing log messages

```python
log.debug("Copying releases/v2 to app/current")
log.info("Backed up current release")

attempt, limit, status = 1, 5, 500
log.warning(f"Health check attempt {attempt}/{limit} failed: HTTP {status}")

log.error("Health check failed after 5 attempts")
```

| Method | Level |
|---|---|
| `log.debug(...)` | `DEBUG` |
| `log.info(...)` | `INFO` |
| `log.warning(...)` | `WARNING` |
| `log.error(...)` | `ERROR` |
| `log.critical(...)` | `CRITICAL` |

A message is emitted only if its level passes both the logger level and the relevant handler level.

## Reading the log file

```python
print("--- what landed in the file ---")
print(log_file.read_text(encoding="utf-8"), end="")
print("--- end of file ---")
```

Because the file handler is set to `DEBUG`, it should contain all five levels of messages. The console handler is set to `INFO`, so it should not show the `DEBUG` message.

## Logging exceptions

```python
try:
    int("not-a-port")
except ValueError as error:
    log.error(f"Could not read port: {error}")
```

This logs the error message but not the full traceback.

To include the traceback automatically, use:

```python
try:
    int("not-a-port")
except ValueError:
    log.exception("Could not read the port from config")
```

- `log.exception()` logs at `ERROR` level.
- It includes the current exception traceback.
- It should be used inside an `except` block.

## Example output

```text
14:32:08 DEBUG    deploy: Copying releases/v2 to app/current
14:32:08 INFO     deploy: Backed up current release
14:32:08 WARNING  deploy: Health check attempt 1/5 failed: HTTP 500
14:32:08 ERROR    deploy: Health check failed after 5 attempts
14:32:08 ERROR    deploy: Could not read the port from config
Traceback (most recent call last):
  ...
ValueError: invalid literal for int() with base 10: 'not-a-port'
```

## Key rule

Use `print()` for direct user-facing output; use `logging` for diagnostic, operational, and error information that needs timestamps, levels, sources, and flexible destinations.
