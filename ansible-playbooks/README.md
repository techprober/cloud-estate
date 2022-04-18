<h1 align="center">Ansible Playbooks</h1>
<p align="center">
    <em>Declare Configuration as Code</em>
</p>
<p align="center">
    <a href="https://t.me/pve_zh">
        <img src="https://img.shields.io/badge/join-us%20on%20proxmox%20group-gray.svg?longCache=true&logo=proxmox&colorB=orange" alt="join-us-on-proxmox-group"/>
    </a>
    <a href="https://docs.ansible.com/ansible/latest/user_guide/playbooks_intro.html">
        <img src="https://img.shields.io/badge/ansible-playbooks-gray.svg?longCache=true&logo=ansible&colorB=red" alt="ansible-playbooks"/>
    </a>
    <a href="https://t.me/joinchat/7AG3aEQ5I00wY2Q5">
        <img src="https://img.shields.io/badge/join-us%20on%20telegram-gray.svg?longCache=true&logo=telegram&colorB=blue" alt="join-us-on-telegram"/>
    </a>
    <a href="https://github.com/TechProber/cloud-estate">
        <img src="https://img.shields.io/github/last-commit/TechProber/cloud-estate" alt="lastcommit"/>
    </a>
</p>

## Table of Contents

- [Reference Links](#reference-links)
- [SSH Configuration](https://github.com/TechProber/cloud-estate/blob/master/playbooks/docs/ssh-configuration.md)
- [Components made up Ansible](#components-made-up-ansible)
- [Automation and Orchestration](#automation-and-orchestration)
- [Installation](#installation)
- [Playbook](#playbook)
- [Task](#task)
- [Tools](#tools)

## Reference Links

- [Ansible Pre-baked Modules](https://docs.ansible.com/ansible/2.9/modules/modules_by_category.html)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [Ansible sudo – ansible become example](https://www.middlewareinventory.com/blog/ansible-sudo-ansible-become-example/)
- [Ansible AUR Module](https://github.com/kewlfft/ansible-aur)

## Components made up Ansible

- `inventory` (list of devices that we will be controlling)
- `roles` (core components that define the automation tasks)
- `playbook` (automation task definition)
- `module` (pre-defined task template that can be called upon automation)
- `variable` (user-defined custom variables that can be injected to Ansible automation)
- `ansible.cfg` (modify default behavior and settings that Ansible uses)

## Project File Structure

```
# tree -d -L 2 ./
.
├── bin
├── docs
├── inventory
├── playbooks
│   ├── apt
│   ├── container
│   ├── local-maintenance
│   ├── maintenance
│   ├── minio
│   └── proxmox
└── roles
    ├── apt.ops
    ├── arch.update
    ├── container.ops
    ├── homebrew.ops
    ├── maintenance.ops
    ├── minio.ops
    └── server.ops
```

##### Notes:

- All the playbooks are stored under `./playbooks/`
- All the playable roles are stored under `./roles/`
- Sample inverntory definition can be found under `./inventory/`

## Automation and Orchestration

- Automation refers to a single task
- Orchestration refers to the management of many automated tasks
- Often a complicated ordering with dependencies

## Installation

```bash
# osx
brew install ansible
# archlinux
sudo pacman -S ansible

# verify installation
ansible --version
```

## Playbook

#### Run a normal playbook against the default hosts

```bash
ansible-playbook [playbook path]
```

#### Run a playbook against an inventory list

```bash
ansible-playbook -i [inventory path] [role path]
```

#### Run a playbook against an inventory list but with limited host

```bash
ansible-playbook -i [inventory path] -l [limited hosts] [role path]
```

#### Run a pre-defined module against hosts

E.g. Run the ping module

```bash
ansible [hostfile path] -m ping
```

#### Run a task in dry-run mode - Ansible check

Check mode is just a simulation. It will not generate output for tasks that use conditionals based on registered variables (results of prior tasks). However, it is great for validating configuration management playbooks that run on one node at a time. To run a playbook in check mode:

```bash
ansible-playbook foo.yml --check
```

#### Run a task with sudo – Ansible become

sudo is to execute a task as a root user, in other words, we call it as privileged execution. If you want to execute a certain task as the root user using ansible just `become` is sufficient

Consider the following playbook where I want to install and restart the apache httpd server and I have used only the become method cause I know the default `become_user` is root and it does not have to be mentioned

```yaml
---
- name: Playbook
  ...
  become: yes
  ...
```

#### Ansible become with password

reference: https://www.middlewareinventory.com/blog/ansible-sudo-ansible-become-example/

Consider the same playbook given below for this the only difference we are going to do is passing the password as a parameter while invoking the playbook

How to pass the password as a parameter. ansible-playbook gives you to two options or parameters to pass while you are invoking the playbook

`-K` or `--ask-become-pass`

```bash
ansible-playbook -K [playbook path]
```

Alternative way to run playbook with `-e ansible_become_pass=$ANSIBLE_PASSWORD` but without the need to explicitly type `become` password

```bash
export $ANSIBLE_PASSOWRD=<become password goes here>
ansible-playbook \
  -e ansible_become_pass=$ANSIBLE_PASSWORD \
  [playbook path]
```

#### Enable verbose mode while running the playbook

To understand what is happening when you run the playbook, you can run it with the verbose `-v` option. Every extra v will provide the end user with more debug output.

`-v` or `--verbose`

```bash
ansible-playbook -v [playbook path]
```

## Task

#### Execute a task if it caused a change

Set the `changed_when` parameter as `yes` as the following:

```yaml
changed_when: yes
```

#### Ensure all tasks must complete one one server before proceeding to the next server

Set the `serial` paramter to `1` as the following:

```yaml
serial: 1
```

#### Continuation of the play on a host

For Continuation of the play on a host, without waiting for other hosts, set the `strategy` parameters to the `free` option as the following:

```yaml
strategy: option
```

## Ansible Galaxy

#### Install a collection from Galaxy

reference: https://docs.ansible.com/ansible/latest/galaxy/user_guide.html#installing-a-collection-from-galaxy

```bash
ansible-galaxy collection install community.general --upgrade
```

Alternatively you can include the collection in a `requirements.yml` file and then run `ansible-galaxy collection install -r requirements.yml --upgrade`. Here is an example of `requirements.yml` file:

```yaml
collections:
  - name: kewlfft.aur
  - name: community.general
```

## Tools

### Ansible Lint

```bash
# install with brew
brew install ansible-lint
# install with pip
pip install ansible-lint
# install with pacman
sudo pacman -S ansible-lint
# verify installation
ansible-lint --version
# linting
ansible-lint .
```
