# Virtual Machines

### What is a VM:
A virtual computer (often called a virtual machine or VM) is a software-based emulation of a physical computer.
It runs inside a physical computer but acts like its own completely separate system with its own operating system, CPU, memory, and storage.

### How It Works
* The Host: The physical hardware (the actual server or computer) that provides the raw processing power.
* The Guest: The virtual computer that runs on top of that hardware inside an isolated environment.
* The Hypervisor: The special software that divides the physical hardware into separate, isolated virtual computers.

#### What is EC2(AWS)
* Amazon EC2 (Elastic Compute Cloud) is essentially a service that lets you rent virtual computers in the cloud (AWS service for virtual machines).

### How to get a VM set up (AWS) (EC2)
* Set up SSH(Secure Shell) key pair - public key is installed directly on the EC2 server (acts as a digital padlock) and the private key is a .pem file stored securley on your local device (acts as the key - only you have his)
  * Save the.pem file securley (in ssh file)
  * set the permission chmod 400 filename make it read only
    * `chmod 400 ~/.ssh/*.pem`
* Launch an instance of EC2 on aws, name it and select the OS and instance type, select your key pair, configure network settings
* connect to the VM in SSH client using the prompt given - ensure fingerprints etc matchup and press yes and this should establish connection
* `ssh -i ~/.ssh/tech613-javed-aws-key.pem ubuntu@ec2-63-35-227-241.eu-west-1.compute.amazonaws.com`
### SSH

SSH means **Secure Shell**. It lets you securely access a remote Linux server.

```bash
ssh -i ~/.ssh/tech613-javed-aws-key.pem ubuntu@ec2-3-253-15-215.eu-west-1.compute.amazonaws.com
```

When connected, commands run on the remote Ubuntu server, not on the Mac.

```bash
exit
```

Ends the SSH connection and returns to the Mac Terminal.
