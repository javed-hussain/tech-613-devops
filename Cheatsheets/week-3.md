# Week 3 cheatsheet: DevOps, operating systems, and Python

- **DevOps:** shared ownership, automation, fast feedback, and continuous improvement connect development and operations.
- **OS interfaces:** applications use system calls and APIs to request services from the OS; processes, files, memory, and networking are managed resources.
- **Python collections/functions:** choose lists for ordered mutable sequences and dictionaries for key/value lookup; keep functions focused and return values explicitly.
- **Files and CLI:** use `pathlib.Path` for portable path operations and `argparse` to define validated command-line options and help text.
- **External commands:** use `subprocess.run([...], check=True, capture_output=True, text=True, timeout=...)`; prefer argument lists over shell strings.
- **Logging and networking:** use `logging` levels instead of `print()` for application diagnostics. A socket connects endpoints using an IP address and port; handle timeouts and connection errors.
- **Configuration and secrets:** read environment variables for deployment-specific settings; never commit credentials or print secrets to logs.

See the [Week 3 notes](../Week_3/DevOps.md) and [Python notes](../Week_3/python/Day_1/collections_functions.md).
