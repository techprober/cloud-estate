<h1 align="center">Packer Templates</h1>
<p align="center">
    <em>Declare Proxmox Template as Code</em>
</p>
<p align="center">
    <a href="https://t.me/pve_zh">
        <img src="https://img.shields.io/badge/join-us%20on%20proxmox%20group-gray.svg?longCache=true&logo=proxmox&colorB=orange" alt="join-us-on-proxmox-group"/>
    </a>
    <a href="https://t.me/joinchat/7AG3aEQ5I00wY2Q5">
        <img src="https://img.shields.io/badge/join-us%20on%20telegram-gray.svg?longCache=true&logo=telegram&colorB=blue" alt="join-us-on-telegram"/>
    </a>
    <a href="https://github.com/TechProber/cloud-estate">
        <img src="https://img.shields.io/github/last-commit/TechProber/cloud-estate" alt="lastcommit"/>
    </a>
</p>

## Introduction

Maunally creating and managing VM Templates in Proxmox can become a challenge with how time-consuming and manual it can be. This repo will walk you through how you can make this process more standardized and automated with the use of packer to allow you to declare your `Proxmox Templates as Code`.

## Table of Contents

- [What is Packer](#what-is-packer)
- [Prepare your packer template](#prepare-your-packer-template)

## What is Packer

Packer is a utility that allows you to build virtual machine images so that you can define a golden image as code. Packer can be used to create images for almost all of the big cloud providers such as AWS, GCE, Azure and Digital Ocean, or can be used with locally installed hypervisors such as VMWare, Proxmox and a few others.

To build an image with packer we need to define our image through a template file. The file uses the JSON format and comprises of 3 main sections that are used to define and prepare your image.

<details><summary>Builders</summary>

</br>

> Builders: Components of Packer that are able to create a machine image for a single platform. A builder is invoked as part of a build in order to create the actual resulting images.

</details>

<details><summary>Provisioners</summary>

</br>

> Provisioners: Install and configure software within a running machine prior to that machine being turned into a static image. Example provisioners include shell scripts, Chef, Puppet, etc.

</details>

<details><summary>Post Processors</summary>

</br>

> Provisioners: Install and configure software within a running machine prior to that machine being turned into a static image. Example provisioners include shell scripts, Chef, Puppet, etc.

</details>

</br>

By using packer we can define our golden VM image as code so that we can easily build identically configured images on demand so that all your machines are running the same image and can also be easily updated to a new image when needed.

## Prepare your packer template

To create the template we will use the [ proxmox builder ](https://packer.io/docs/builders/proxmox.html) which connects through the proxmox `web API` to provision and configure the VM for us and then turn it into a template. To configure our template we will use a `variables file`, to import this variables file we will use the `-var-file` flag to pass in our variables to packer. These variables will be used in our template file with the following syntax within a string like so `passwd/username={{ user 'ssh_username'}}`.

Now the builder block below will outline the basic properties of our desired proxmox template such as its name, the allocated resources and the devices attached to the VM. To achieve this the [ boot_command ](https://packer.io/docs/builders/qemu.html#boot-configuration) option will be used to boot the OS and tell it to look for the preseed file to automate the OS installation process. Packer has an inbuilt HTTP server to serve this [ preseed.cfg ](https://github.com/Aaron-K-T-Berry/packer-ubuntu-proxmox-template/blob/master/http/preseed.cfg) file to the VM as its installing by using the [ http_directory ](https://packer.io/docs/builders/qemu.html#http_directory) option in the builder to specify the public files of the HTTP server. [ Check out the ubuntu preseed documentation ](https://help.ubuntu.com/lts/installation-guide/s390x/apbs02.html) for info on modifying the automatic installation process of the OS via a pre seed file.
