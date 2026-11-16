# SSH Key Setup

## General idea
- SSH provides a secure connection between your computer and GitHub.
- A key pair contains:
  - Private key: stays on your computer; keep it secret.
  - Public key: uploaded to GitHub.
- Your computer proves it holds the private key; GitHub verifies this using the public key.
- The private key is never sent to GitHub.
- Authentication identifies your account; repository permissions determine whether you can push.
- Keys are geberally stored in

## 1. Generate a key pair
    ssh-keygen -t rsa -b 4096 -C "yourownpersonalemail"

- `-t rsa`: uses the RSA algorithm.
- `-b 4096`: sets the key size to 4096 bits.
- `-C`: adds a comment/label; it is not used for authentication.
- enter the filename

Creates:
- `key_name`: private key—keep secret.
- `key_name.pub`: public key—add to GitHub.

## 2. Start the SSH agent
    eval `ssh-agent -s`

- The SSH agent is a background program that holds private keys in memory.
- It creates authentication signatures without sending your private key to GitHub.
- It avoids repeatedly entering your key's passphrase.
- `eval` applies the agent's environment settings so your terminal can communicate with it.

## 3. Add your private key to the agent
    ssh-add firstname-github-key

- Loads the private key into the agent.
- Enter the key's passphrase if prompted.
- Use the key's full path if it is stored in another directory.

## 4. Add the public key to GitHub
Copy the contents of `key_name.pub` into: GitHub → Settings → SSH and GPG keys → New SSH key. 
Never upload the private key.

## 5. Test the connection
    ssh -T git@github.com

Expected message:
    Hi USERNAME! You've successfully authenticated, but GitHub does not provide shell access.

- Authentication worked.
- “No shell access” is normal—GitHub supports Git operations, not an interactive terminal.

## How authentication works
1. Git connects to GitHub over SSH.
2. SSH asks the agent to sign authentication data.
3. The agent signs using your private key.
4. GitHub verifies the