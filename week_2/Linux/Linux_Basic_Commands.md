## Useful Linux commands

| Command | Purpose |
|---|---|
| `pwd` | Show current folder |
| `ls` | List files and folders |
| `ls -la` | List all files, including hidden files, with details |
| `cd folder` | Move into a folder |
| `cd ..` | Move to the parent folder |
| `cd ~` | Move to the home folder |
| `mkdir folder` | Create a folder |
| `touch file.txt` | Create an empty file |
| `cat file.txt` | Display file contents |
| `nano file.txt` | Edit a file in Terminal |
| `cp file1 file2` | Copy a file |
| `mv old new` | Rename or move a file |
| `rm file.txt` | Delete a file |
| `rm -r folder` | Delete a folder and its contents |
| `clear` | Clear the terminal |
| `history` | Show previous commands |
| `man command` | Open a command manual |
| `exit` | End the SSH session |
| `--help`| Shows helpful options |

a

## `sudo`

`sudo` runs a command with administrator permissions.

```bash
sudo apt update
```

Be careful when using `sudo`, especially with file deletion commands.

## APT package manager

Ubuntu uses `apt` to manage software packages.

```bash
sudo apt update
```

Updates the list of available software.

```bash
sudo apt upgrade -y
```

Installs available software updates.

```bash
sudo apt install git -y
```

Installs Git.


## curl

`curl` transfers data to or from a URL.

```bash
curl [https://example.com](https://example.com)       # Fetch and display a URL
curl -I [https://example.com](https://example.com)    # Show response headers only
curl -L URL                    # Follow redirects
curl -o file URL               # Download and choose file name
curl -O URL                    # Download using original file name
curl -X POST -d "a=b" URL      # Send POST data
```