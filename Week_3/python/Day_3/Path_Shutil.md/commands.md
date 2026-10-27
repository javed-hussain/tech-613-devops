# `pathlib` commands

| Command / expression | Meaning |
|---|---|
| `Path("releases")` | Creates a path object; does not create a folder |
| `Path("a") / "b" / "file.py"` | Joins path parts |
| `Path.cwd()` | Current working directory |
| `Path.home()` | Current user’s home directory |
| `Path("~/project").expanduser()` | Converts `~` to the real home directory |
| `path.name` | Final component, e.g. `app.py` |
| `path.stem` | Filename without extension, e.g. `app` |
| `path.suffix` | Extension, e.g. `.py` |
| `path.parent` | Containing folder |
| `path.parts` | Tuple of all path components |
| `path.exists()` | `True` if the file or directory exists |
| `path.is_file()` | `True` if the path is a file |
| `path.is_dir()` | `True` if the path is a directory |
| `Path(".").iterdir()` | Lists items in the current directory |
| `Path(".").glob("*.py")` | Finds matching files in the current directory only |
| `Path(".").rglob("*.py")` | Recursively finds matching files in current and subdirectories |
| `path.mkdir()` | Creates a directory |
| `path.mkdir(parents=True)` | Creates missing parent directories too |
| `path.mkdir(exist_ok=True)` | Does not error if the directory already exists |
| `path.write_text(text, encoding="utf-8")` | Creates/overwrites a file and writes text |
| `path.read_text(encoding="utf-8")` | Reads a text file |
| `path.unlink()` | Deletes a file |
| `path.rmdir()` | Deletes an **empty** directory |

## `shutil`

| Command | Meaning |
|---|---|
| `shutil.copy(src, dst)` | Copies a file |
| `shutil.move(src, dst)` | Moves or renames a file/directory |
| `shutil.rmtree(path)` | Deletes a directory and everything inside it |
| `shutil.copytree(src, dst)` | Copies an entire directory tree |
| `shutil.copytree(src, dst, dirs_exist_ok=True)` | Copies into an existing destination, merging folders |
| `shutil.disk_usage("/")` | Returns total (usage.total), used, and free disk space |
| `shutil.which("git")` | Returns full path to an executable on `PATH`, or `None` |

