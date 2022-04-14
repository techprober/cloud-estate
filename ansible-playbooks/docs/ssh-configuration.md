# SSH Configuration Guide

## Setup

#### Generate a pair of ssh-key (if you do not have one yet)

```bash
ssh-keygen
```

#### Copy ssh key to target machine

```bash
ssh-copy-id $HOME/.ssh/[KEY NAME].pub [SEVER IP or DOMAIN]
```

#### Edit `$HOME/.ssh/config`

```config
Host [SEVER NAME]
  HostName [SEVER IP ADDRESS or DOMAIN]
  User root
  IdentityFile ~/.ssh/id_rsa
```
