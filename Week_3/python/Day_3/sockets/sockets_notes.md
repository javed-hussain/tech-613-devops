# Python `socket` Notes

A socket is an endpoint for sending and receiving data over a network. It is identified by an IP address and a port number, such as `127.0.0.1:8801`.

In this lab, sockets are used to check whether a service is listening: try to open a TCP connection, and treat success as “the service is up”.

## Core idea

```python
import socket

with socket.create_connection((host, port), timeout=timeout):
    return True
```

- `socket.create_connection((host, port))` tries to open a TCP connection.
- The address is a tuple: `(host, port)`.
- `timeout` limits how long Python waits.
- If the connection succeeds, something is listening on that host and port.
- If it fails, Python raises an `OSError` or one of its subclasses.
- `with` ensures the socket is closed after the attempt.

## Basic health check

```python
def is_listening(host="127.0.0.1", port=8801, timeout=2.0):
    try:
        with socket.create_connection((host, port), timeout=timeout):
            return True
    except OSError:
        return False
```

| Outcome | Result |
|---|---|
| Connection succeeds | `True` — something is listening |
| Refused, timeout, DNS failure, or other OS/network error | `False` |

This answers **whether** the service is up, but not **why** it is down.

## Detailed health check

```python
def check_detail(host, port, timeout=2.0):
    try:
        with socket.create_connection((host, port), timeout=timeout):
            return "up"
    except socket.timeout:
        return "timed out"
    except socket.gaierror:
        return "unresolvable"
    except ConnectionRefusedError:
        return "refused"
    except OSError as error:
        return f"error: {error}"
```

| Exception | Meaning | Return value |
|---|---|---|
| No exception | TCP connection accepted | `"up"` |
| `socket.timeout` | Connection attempt took too long | `"timed out"` |
| `socket.gaierror` | Hostname could not be resolved | `"unresolvable"` |
| `ConnectionRefusedError` | Nothing listening, or connection refused | `"refused"` |
| `OSError` | Any other network/operating-system error | `"error: ..."` |

## Exception order matters

Catch specific exceptions before `OSError`:

```python
except socket.timeout:
    ...
except socket.gaierror:
    ...
except ConnectionRefusedError:
    ...
except OSError as error:
    ...
```

`socket.timeout`, `socket.gaierror`, and `ConnectionRefusedError` are types of `OSError`. If `except OSError` came first, it would catch them all and hide the specific reason.

## Common addresses

| Address | Meaning |
|---|---|
| `127.0.0.1` | Localhost: this same computer |
| `localhost` | Human-readable name for localhost |
| `0.0.0.0` | Usually means “all network interfaces” when a server binds |
| Port `80` | Common HTTP port |
| Port `8801` | Example custom service port |

## Starting and checking a service

Use `subprocess.Popen()` for a long-running service:

```python
proc = subprocess.Popen(
    [sys.executable, str(SERVICE), str(port)]
)
```

- `Popen` starts the process and returns immediately.
- `subprocess.run()` would wait forever because the service does not exit.
- The service may take a moment to bind to its port, so check repeatedly.

## Waiting for a service

```python
def wait_until_listening(host="127.0.0.1", port=8801, attempts=10, delay=0.2):
    for _ in range(attempts):
        if is_listening(host, port):
            return True
        time.sleep(delay)
    return False
```

- Polling means checking repeatedly rather than once.
- `time.sleep(delay)` gives the service time to start.
- Return `True` as soon as the port answers.
- Return `False` after the retry budget is exhausted.

This is the same shape as a health-check retry loop or a Kubernetes readiness probe.

## Stopping a service

```python
def stop_service(proc, timeout=5):
    proc.terminate()

    try:
        return proc.wait(timeout=timeout)
    except subprocess.TimeoutExpired:
        proc.kill()
        return proc.wait()
```

| Method | Meaning |
|---|---|
| `proc.terminate()` | Politely asks the process to stop |
| `proc.wait(timeout=...)` | Waits for exit, up to a time limit |
| `proc.kill()` | Force-kills the process |
| `proc.wait()` | Waits for final exit and returns its return code |

Always wait after terminating or killing a process. Otherwise, your code may continue while the port is still held, preventing a replacement service from binding to it.

## Platform-specific ping

```python
count_flag = "-n" if platform.system() == "Windows" else "-c"

result = subprocess.run(
    [ping_path, count_flag, "1", host],
    capture_output=True,
    text=True,
    timeout=timeout,
)

return result.returncode == 0
```

- Windows `ping` uses `-n` for count.
- macOS and Linux use `-c`.
- Check `returncode`, not ping’s text output, because wording can vary by system language.
- Use `shutil.which("ping")` first and raise a clear error if it is missing.

## Key rule

Use `socket.create_connection((host, port), timeout=...)` to test whether a TCP service is listening. Catch specific socket exceptions before `OSError` when you need to explain why the service is unavailable.
