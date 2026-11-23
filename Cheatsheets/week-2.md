# Week 2 cheatsheet: Linux, Git, Markdown, and VMs

- **Linux paths:** `/` is the filesystem root; `~` is your home directory. Use `pwd`, `ls -la`, `cd`, `find`, and `less` to navigate and inspect.
- **Files and permissions:** `r=4`, `w=2`, `x=1`; permissions are owner/group/others (for example, `chmod 750 file`). Use `sudo` only when elevated access is needed.
- **Processes and streams:** inspect with `ps`/`top`, stop with `kill`; stdout is 1, stderr is 2. Redirect with `>`, append with `>>`, and combine streams with `2>&1`.
- **Git loop:** `status` → `add` → `commit`; share with `push`, receive with `pull`. Work on a branch, review changes, then merge. Commit small, meaningful changes.
- **VMs and SSH:** a VM provides an isolated guest OS; connect to a remote host with `ssh -i key.pem user@host`. Protect private keys and use appropriate key permissions.
- **Markdown:** use `#` headings, `-` lists, `[label](path)` links, and triple backticks for code blocks.

See the [Week 2 notes](../week_2/git/gitNotes.md) and [Linux notes](../week_2/Linux/notes/linux.md).
