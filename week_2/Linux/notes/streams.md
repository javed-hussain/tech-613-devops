# Scripts
1. What is a stream in Linux?
 * A stream in Linux is a flow of data between a program and somewhere else — usually your keyboard, terminal, a file, or another command.
2. What are the 3 data streams?

| Symbol | Meaning | Default connection | Purpose |
|---|---|---|---|
| Standard Input (stdin) |`0`| Keyboard | Data going into a command |
| Standard Output (stdout) | `1` | Terminal | Normal results produced by a command |
| Standard Error | `2` | Terminal | Errors and diagnostic messagess |

3. How can we direct each stream to a file (one at a time)?
* We use `>` to redicrect a stream one at a time
* `ls missing_directory new.txt > stdout.txt` : directs the Standard Output into stdout.txt (If file doesnt exist it will create it)
* `>` = `1>` = redirect standard output `2>` = redirect error output


4. How can we direct both 2 output streams to a file?
* Use both redirections in one command:
    * `ls missing_directory new.txt > stdout.txt 2> stderr.txt`
  
  
5. Which stream is directed to a file by default?
* \> directs standard output (1) by default 

6. How can we direct both output streams to a file in one command?
   * If we want to send both to the same file in one command:
    * `ls missing_directory new.txt > combined.txt 2>&1`
      * `> combined.txt` sends stdout (stream 1) to combined.txt.
      * `2>&1` sends stderr (stream 2) to wherever stdout is now going—also combined.txt.

### Redirecting and Appending

1. What does > do?
* This is the redirect command - redirects a stream to a specified file

2. How is appending different?
* Redirect will redirect data to a file, this overwrites the content of said file with the stream (deletes old content replaces with new stream) however appending `>>` adds the stream to the end of a file, doesnt delete the content of the file at all
