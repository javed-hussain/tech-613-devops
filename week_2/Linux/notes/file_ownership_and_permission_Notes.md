# Linux File Management Research
- [Linux File Management Research](#linux-file-management-research)
  - [Task 1: Research managing file ownership](#task-1-research-managing-file-ownership)
  - [Task 2: Managing File Permissions](#task-2-managing-file-permissions)
  - [Task 3: Research Numeric File Permission Values](#task-3-research-numeric-file-permission-values)
  - [Task 4: Research Changing File Permissions](#task-4-research-changing-file-permissions)
      - [Syntax for permission changes](#syntax-for-permission-changes)

## Task 1: Research managing file ownership
1. Why is managing file ownership important?
   * Managing file ownership is important because it determines who is responsible for and allowed to control a file or directory.
   * Along with permissons protects users privates files, prevents unauthprised edits and supports multi-server/server environments
2. What is the command to view file ownership?
   *    `ls -l` or `ls -l specific file name`
   *    Example output : `-rw-r--r-- 1 ubuntu ubuntu 0 Oct 7 15:00 notes.txt`

| Output | Meaning |
|---|---|
| first char (`-`)|file type|
| `rw-r--r--` | Permissions |
| `1` | Number of hard links to the file |
| First `ubuntu` | File owner |
| Second `ubuntu` | Group owner |
| `0` | File size in bytes |
| `Oct 7 15:00` | Last modified date and time |
| `notes.txt` | File name |

1. What permissions are set when a user creates a file or directory? Who does the file or directory belong to?
   * The user who creates a file or directory becomes its owner.
   * The file or directory normally belongs to the creator's primary group.
   * Systems have a `umask` which is a default permission filter, this removes permissions from new files and directories when they are created
   * `umask` command to see your current umask.

2. Why does the owner, by default, not receive X permissions when they create a file?
   * New files are usually text or data files, not programs.
   * Giving execute (`x`) permission automatically could allow unsafe files or scripts to run accidentally.
   * Execute permission can be added manually when needed


5. What command is used to change the owner of a file or directory?
   * Use `chown`, meaning **change owner**.
  
| Command | Purpose |
|---|---|
| `sudo chown new-owner filename` | Changes the user owner of a file |
| `sudo chown new-owner:new-group filename` | Changes both the user owner and group owner |
| `sudo chown -R new-owner:new-group folder-name` | Changes ownership of a directory and all contents inside it |

## Task 2: Managing File Permissions

1. Does being the owner of a file mean you have full permissions on that file? Explain.
    * No. Being the owner of a file does not automatically give you full permissions.
    * The owner only receives the permissions set in the user/owner permission section determined by the default umask
2. If you give permissions to the User entity, what does this mean?
   * User entity is the user who owns the file or directory (permissions are the first 3 characters in the permissions)
3. If you give permissions to the Group entity, what does this mean?
   * Users who belong to the file or directories assigned `group`
   * Groups are a named collection of linux user accounts, use command `groups` or `id` to see your groups
   * middle 3 characters are group permissions
4. If you give permissions to the Others entity, what does this mean?
   * Permissions for all users who are not the owner of group members
   * last 3 characters are others permissions

Example output: `-rwxr-xr-- 1 tcboony staff  123 Nov 25 18:36 keeprunning.sh`
* owner is tcboony, group is staff, there is 1 hard link to the file, 123 is file size in bytes, last modified Nov 25 18:36
* first char `-`: means it is a regular file
* `rwx`: user/owner permish: read write execute
* `r-x`: group permish: read write
* `r--`: others permish read only

## Task 3: Research Numeric File Permission Values
* Linux assigns numeric values to each type of permission
* >Read (r) = 4, Write (w) = 2, Execute (x) = 1
* For each class (users, groups, others), add the values of the permissions
  * eg, read and write = 4 + 2 = 6,  read + write + execute = 1 + 4 + 2 = 7
* File permissions are often represented with 3 digits, this is because the 1st digit represents the owners permissions, second is groups, third is others
  * eg 644 means owner/user has read+write, group has read only, others have read only

## Task 4: Research Changing File Permissions
1. What command changes file permissions?
   *  `chmod "ugo permissions" file_name`
   *  eg, `chmod 740 testfile.txt` changes testfile.txt permissions to rwx for user, read only for group and none for others
2. To change permissions what must the end user be?
   1. The owner of the file
   2. The root account (superuser) or using sudo to get the same privelages

#### Syntax for permission changes
* a = all , u = owner/user, g = group, o = other, r = read, w = write, x = execute
* a+r : add r permission to all (`chmod a+r filename`)
* o-x: remove execute permission from others
* Or we specify the numeric value for each user type permission 