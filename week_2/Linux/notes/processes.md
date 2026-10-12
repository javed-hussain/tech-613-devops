# Processes:

* A Process is a program (a file containing insturctions) that is currently running
* User Processes are programs that are started by a person/user typically from the terminal
  * `ps` lists user processes
* System Processes are background programs that linux starts and uses to get the computer working
  * `ps aux` shows a detailed snapshot of all processes
  * a = included processes from other users that have a terminal
  * u = user orientated detailed format
  * x = include processes without a terminal such as background services

## `top` 

`top` command is a live interactive moniter
`htop` command is a more user friendly version

| Key | What it does |
|---|---|
| `q` | Quit `top` |
| `h` or `?` | Show the help screen |
| `P` | Sort processes by CPU usage |
| `M` | Sort processes by memory usage |
| `T` | Sort processes by total CPU time used |
| `1` | Show CPU usage for each individual CPU core |
| `c` | Toggle between the process name and full command line |
| `u` | Filter processes by user |
| `k` | Send a signal to a process, including stopping/killing it |
| `r` | Change a process priority (nice value) |

## Parent and child processes

* A parent process is a process that starts another process. The process it starts is called a child process.
* PID is process ID and PPID is the PID of the parent process
* `ps -ef` lists all processes with a PPID column
* the processes with a PPID of 0 are started by the OS


### Jobs

* jobs show programs that ypu started from your current termina that are still running in the background or have been paused
* Each job is given a job number
* To start a command in the background we add an & after the command
* `jobs` command lists job `-p` lists with PID

### Kill command
* The Kill command (`kill -x PID`)sends signals, there are 64 possible signals (kill -l to list them)
* default for kill is kill -15 - politley asks to stop process
*  Harshest level is kill -9 which is a brute force kill
   *  no chance to save data close connections release locks - straight kill immediate
* Foreground processes are ended using ctrl c or can be paused with ctrl z and resumed in background with `bg`
* Some Parents are respnsible for running child processes, so if the child process gets killed, the parent will recreate that child process and have a new PID, everytime the child gets killed the parent recreates it. In this scenarios we will need to kill the parent
  * If we try a graceful (-15) on the parent it will try and shutdown the child processes - if we dont use graceful kills the children may be left running in memory and then become zombie processes - requires manual cleanup.