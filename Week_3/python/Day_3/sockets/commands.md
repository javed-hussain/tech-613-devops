# Socket & Service Commands

| Command | Meaning |
|---|---|
| `socket.create_connection((host, port), timeout=n)` | Try to open a TCP connection |
| `with socket.create_connection(...)` | Close the socket automatically afterwards |
| `socket.timeout` | Connection timed out |
| `socket.gaierror` | Hostname could not be resolved |
| `ConnectionRefusedError` | Nothing listening / connection refused |
| `OSError` | General network or OS error |
| `subprocess.Popen([...])` | Start a background process; returns immediately |
| `proc.terminate()` | Politely stop the process |
| `proc.kill()` | Force-stop the process |
| `proc.wait(timeout=n)` | Wait for exit; raise `TimeoutExpired` if too slow |
| `proc.poll()` | `None` if still running, else return code |
| `proc.returncode` | Exit code after the process finishes |
| `proc.pid` | Process ID |
| `time.sleep(n)` | Pause for `n` seconds before retrying |
| `subprocess.run([...], timeout=n)` | Run a command with a time limit |
| `subprocess.TimeoutExpired` | Command/process took too long |
| `subprocess.CalledProcessError` | Command failed when `check=True` |
| `shutil.which("ping")` | Find an executable on `PATH`, or `None` |
| `platform.system()` | Returns `"Windows"`, `"Darwin"`, or `"Linux"` |
| `sys.executable` | Path to the current Python interpreter |
| `Path(__file__).parent` | Folder containing the current script |

## Health-check results

| Result | Meaning |
|---|---|
| `"up"` | Something is listening |
| `"refused"` | Nothing listening / connection refused |
| `"timed out"` | No response in time; possibly firewall |
| `"unresolvable"` | DNS could not resolve the host |
| `"error: ..."` | Any other network/OS failure |
