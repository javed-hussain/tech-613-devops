# Docker Intro

## Containerisation vs Virtualisation
- **Virtualisation** abstracts physical hardware, allowing multiple virtual machines (VMs) to run on one physical host.
- **Containerisation** packages an application with its dependencies, so it runs consistently across different environments.
- Both provide isolation, but at different levels: VMs virtualise hardware, while containers virtualise the operating system.

#### Virtual machines

A VM includes:
- A hypervisor, which manages and allocates host hardware resources.
- A complete guest operating system, including its own kernel.
- Application code, libraries, and dependencies.
Because each VM runs a full OS, it provides strong isolation but uses more CPU, memory, storage, and startup time.

#### Containers
A container includes:
- Application code.
- Runtime, libraries, and dependencies.
- A lightweight OS-level environment, but **not** a full guest OS or separate kernel.
Containers share the host operating system’s kernel while running as isolated processes. This makes them smaller, faster to start, and more resource-efficient than VMs. - high portability - high scalability - fault tolerance - agility (changes can be made without interferring with OS) - compared to VMs

#### Key differences

| Aspect | Virtual machine | Container |
|---|---|---|
| Virtualises | Physical hardware | Operating system |
| Includes | Full guest OS and kernel | App code and dependencies only |
| Kernel | Separate kernel per VM | Shares host kernel |
| Resource use | High | Low |
| Startup time | Slower | Fast |
| Isolation | Stronger | Lightweight isolation |
| Portability | Less portable due to full OS | Highly portable (no need to rewrite code for diff systems) |
| Typical use | Running different OSs, strong isolation | Microservices, deployment, development |

#### When to use each

- **Use a VM** when you need a different operating system, stronger isolation, or a full system environment.
- **Use a container** when you need lightweight, fast, repeatable application deployment.
- **Use both together** in cloud environments: VMs often provide the underlying infrastructure, while Docker containers run applications efficiently on top of them.

> **VMs virtualise hardware; containers virtualise the operating system.**  
> VMs are heavier and more isolated; Docker containers are lighter, faster, and easier to deploy consistently.

## Docker’s role


#### The problem

- Apps can work on one machine but fail on another.
- Causes: different OS, dependency versions, configurations, and missing tools.
- Known as: **“It works on my machine.”**

## What Docker does

- It is a command line utility to manage and run containers
- Packages an app with its dependencies into a **container**.
- Ensures the app runs the same everywhere.
- Makes development, testing, and deployment more consistent.
- dockerer is open-source, reliable and compatible, simple and fast, usable on multi-cloud - in built security features

## Benefits
- **Consistency:** Same environment across machines.
- **Portability:** Run the same container locally, in the cloud, or on a server.
- **Isolation:** Apps and dependencies do not conflict.
- **Efficiency:** Containers are lightweight and share the host OS kernel.
- **Fast startup:** Containers start in seconds.
- **Easy scaling:** Run multiple containers easily.
- **Simpler onboarding:** New developers can start the project with one command.
- No need to buy new hardware - can run your app from anywhere 

# Real Reasons to Use Docker

- No need to buy new hardware: Containers use fewer resources than VMs, allowing more apps to run on existing hardware. Extra capacity may still be needed as demand grows.

- Run your app anywhere: Deploy the same image on a laptop, server, or cloud using a compatible container environment—not literally every machine.

- Abstract the dependencies: Package required libraries and runtimes with the app, rather than installing them manually on each host. This reduces setup issues and version conflicts.

- Move towards microservices: Run separate services, such as authentication and payments, in their own containers so they can be deployed, updated, and scaled independently.

- Be prepared for the future: Learn a tool used in cloud deployment, automated testing, and CI/CD workflows. This means adopting modern practices—not guaranteed future-proofing.

## Example

Without Docker:

```bash
Install Node.js
Install database
Set environment variables
Install dependencies
Fix version issues
```

With Docker:

```bash
docker compose up
```

> Docker removes environment differences by packaging an app and its dependencies into a portable container.

#### Docker Alternative:
- Podman (POD Manager)
- also open-source, it is deamonless - doesnt need a service running like docker, better security, already installed with many dists of linux, many same commands as docker
- 

