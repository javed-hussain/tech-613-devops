# Paths and Files navigation using Pathlib and Shutil




## Creating paths



`Path` turns a string into a path object that works across operating systems.

```python
releases = Path("releases")
version = releases / "v2" / "app.py"

print(version)  # releases/v2/app.py
```

- Use `/` to join path parts. creates new path objects
- `Path("...")` creates a path object; it does **not** create a file or folder.


Python does not understand `~` on its own:

```python
print(Path("~/deploy-project").expanduser())
```

`expanduser()` converts `~` into the real home directory.

## Path components

```python
script = Path("/tmp/example/deploy.py")

print(script.parent)                  # /tmp/example
print(script.parent / "deploy.yaml")  # /tmp/example/deploy.yaml
```

For:

```python
p = Path("releases/v2/app.py")
```

| Expression | Result | Meaning |
|---|---|---|
| `p.name` | `app.py` | Final component |
| `p.stem` | `app` | Filename without extension |
| `p.suffix` | `.py` | File extension |
| `p.parent` | `releases/v2` | Containing folder |
| `p.parts` | `('releases', 'v2', 'app.py')` | All path components |

## Checking paths

```python
print(p.exists())   # Does the path exist?
print(p.is_file())  # Is it a file?
print(p.is_dir())   # Is it a directory?
```

## Listing a directory

```python
for item in sorted(Path(".").iterdir()):
    kind = "dir " if item.is_dir() else "file"
    print(f"{kind} {item.name}")
```

- `Path(".")` means the current working directory.
- `iterdir()` lists every item in that folder.
- Results are unordered, so use `sorted()` for predictable output.

## Searching for files

```python
for py in sorted(Path(".").rglob("*.py")):
    print(py)
```

- `rglob("*.py")` recursively searches the current folder and all subfolders.
- `glob("*.py")` searches only the current folder.
- `*.py` matches files ending in `.py`.

## Creating directories

```python
backup = Path("app/backup")
backup.mkdir(parents=True, exist_ok=True)
```

- `mkdir()` creates a directory.
- `parents=True` creates missing parent folders too.
- `exist_ok=True` avoids an error if the directory already exists.

## Creating, writing, deleting files

```python
f = Path("temp.txt")

f.write_text("scratch\n", encoding="utf-8")
f.unlink()

print(f.exists())  # False
```

- `write_text()` creates the file if needed and writes text.
- `unlink()` deletes a file.
- `exists()` confirms deletion.

## Creating and deleting directories

```python
d = Path("empty-dir")

d.mkdir(exist_ok=True)
d.rmdir()
```

- `rmdir()` deletes an **empty** directory only.
- Use `shutil.rmtree()` to delete a directory and everything inside it.

## `shutil`

```python
import shutil
```

`shutil` provides high-level file and directory operations, including copying, moving, deleting directory trees, archiving, and checking disk usage.

## Disk usage

```python
usage = shutil.disk_usage("/")

print(f"total {usage.total / 1e9:.1f} GB")
print(f"used  {usage.used / 1e9:.1f} GB")
print(f"free  {usage.free / 1e9:.1f} GB")
print(f"{usage.used / usage.total:.1%} full")
```

- `disk_usage("/")` checks the root filesystem.
- `.total`, `.used`, and `.free` are measured in bytes.
- Divide by `1e9` for approximate GB values.
- `:.1%` formats a proportion as a percentage with one decimal place.

## Copying, moving, deleting

```python
shutil.copy("commands.py", "app/backup/app.py")
shutil.move("draft.txt", "archive/draft.txt")
shutil.rmtree("old_builds")
shutil.copytree("project", "project_backup")
```

| Function | Purpose |
|---|---|
| `shutil.copy(src, dst)` | Copies a file |
| `shutil.move(src, dst)` | Moves or renames a file or directory |
| `shutil.rmtree(path)` | Deletes a directory and all its contents |
| `shutil.copytree(src, dst)` | Copies an entire directory tree |

`copytree()` fails by default if the destination already exists. Use `dirs_exist_ok=True` to copy into an existing destination.

## Finding executables

```python
print(shutil.which("git"))
print(shutil.which("definitely-not-a-real-program"))
```

- `shutil.which("git")` returns the full path to the `git` executable if it is on `PATH`.
- It returns `None` if the program is missing or not executable.
- It is the Python equivalent of `which git` in the terminal.
