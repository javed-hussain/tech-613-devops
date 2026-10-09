# Useful Linux commands

| Command | Purpose |
|---|---|
| `pwd` | Show current folder |
| `ls` | List files and folders |
| `ls -la` | List all files, including hidden files, with details |
| `cd folder` | Move into a folder |
| `cd ..` | Move to the parent folder (one . means current folder 2 .. means parent)|
| `cd ~` | Move to the home folder |
| `mkdir folder` | Create a folder |
| `touch file.txt` | Create an empty file |
| `cat file.txt` | Display file contents |
|`file file_name`| shows information about the file specified|
| `nano file.txt` | Edit a file in Terminal |
| `cp file1 file2` | Copy file1 with name file 2 |
| `mv old new` | Rename or move a file |
| `rm file.txt` | Delete a file |
| `rm -r folder` | Delete a folder and its contents **DANGER** |
| `clear` | Clear the terminal |
| `history` | Show previous commands |
| `man "command"` | Open a command manual for the specified command (eg `man ls` will open a manual for the ls command)|
| `exit` | End the SSH session |
| `--help`| Shows helpful options eg `rm --help` shows options for rm command|
|`head -n` |returns first n number of lines of a file|
|`tail -n` |returns last n number of lines of a file|
|`nl filename` |returns numbered lines of a file|
|`cat filename` |returns content of a file|
|`cat filename \| grep word` |searches for and returns instances of word in filename|


## Sudo

`sudo` runs a command with administrator permissions.

```bash
sudo apt update
```

Be careful when using `sudo`, especially with file deletion commands.

`sudo su`: su switches user, if no user specified then defaults to root user

## APT package manager

Ubuntu uses `apt` to manage software packages.

`apt-get`: use this when automating scripts
`apt`: when using command line it works

| Command | What it does |
|---|---|
| `sudo apt update` | Downloads the latest list of available software packages. It does not install updates. |
| `sudo apt upgrade -y` | Installs available updates for software already installed. `-y` automatically confirms prompts. |
| `sudo apt install git -y` | Installs Git. `-y` automatically confirms prompts. |



## Curl

`curl` transfers data to or from a URL.

| Command | What it does |
|---|---|
| `curl URL` | Fetches content from a URL and displays it in the terminal. |
| `curl -I URL` | Shows only HTTP response headers, such as the status code and content type. |
| `curl -L URL` | Follows redirects to the final URL. |
| `curl -o file URL` | Downloads content and saves it using the filename you choose. |
| `curl -O URL` | Downloads a file and keeps its original filename from the URL. |
| `curl -X POST -d "data" URL` | Sends data to a URL using a POST request. |
| `curl --help` | Displays help and available `curl` options. |

#### Update and Upgrade
`sudo apt update` : downloads latest packages from ubuntus repos, refreshes systems package index
`sudo apt upgrade`: downloads and installs the newer versions of installed packages
apt update checks for new versions; apt upgrade actually installs the newer versions of software you already have

#### Tree

* this package displays file structure in a tree format
* `sudo apt-get install tree`
* and then the command tree shows the files