## Shell environment variables

| Command | Meaning |
|---|---|
| `VAR=value python3 script.py` | Sets `VAR` only for that one command |
| `export VAR=value` | Makes `VAR` available to commands in the current shell session |
| `unset VAR` | Removes `VAR` from the current shell session |
| `os.environ["VAR"]` | Reads a required variable; raises `KeyError` if missing |
| `os.environ.get("VAR")` | Reads an optional variable; returns `None` if missing |
| `os.environ.get("VAR", "default")` | Reads an optional variable with a fallback value |
| `os.getenv("VAR", "default")` | Same practical behaviour as `os.environ.get()` |