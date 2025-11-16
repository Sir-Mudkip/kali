## Overview

This is a Kali container with almost every tool I can think of. This includes of your general tools
you'd likely use for pentesting of web apps, cloud, networks, and some wireless support.

***Please do not use this container for destructive or illegal activities!!!!***

### Credit:

I did not build the structure to this container file. The credit must go to my colleuge and
cloud hacking guru ["Shaunography"](https://gitlab.com/shaunography), creator of Snotra, please find the links below:

- https://snotra.uk/
- https://gitlab.com/snotra.uk
- https://gitlab.com/snotra.cloud

This is just a project of mine that I want to do to get used to making some dockerfiles and using
github. I have added a few of my own tools to this that I tend to use on a more frequent basis such
as:
- testssl
- NoPrompt
- Linkedin-dumper

There's a few more I'm not thinking of but those are the main ones that come to mind. This also
comes with my own personal keybinds and plugins for neovim and tmux.
### Installing:

This can be done in a few different ways.

1) Clone the repository and build the file locally:

```bash
git clone https://Sir-Mudkip/kali.git
```

2) Pull the repository from GitLab:
```bash
docker pull [IMAGE NAME]
```

### Alias:

I suggest that you run the following command to run the container:
```bash
sudo podman run \
    -it \
    --rm \
    --security-opt label=disable \
    --network host \
    --privileged \
    -v $HOME:/run/host \
    [IMAGE NAME]
```

- If using docker, replace the podman command with docker (make sure to run as sudo!)
- `--security-opt` is the required if SELinux is enabled
- `--privileged` is for low level network access
- `--netowork host` for catching shells
- To enable GPU passthrough and use hashcat in the container, then add `--gpus all \` into the
command before the image name.

> [!important] GPU Passthru
> To use GPUs in a container, you will need the Nvidia drivers, the CUDA toolkit, and the Nvidias
> container toolkit to enable GPU passthru. Thankfully you will only need the drivers, the CUDA
> toolkit can be installed in the container and if you enable passthru it should just work.

I don't recommend using hashcat in this container as it's already quite big. I have an ongoing
project which will seek to make a hashcat container more usable.

ALSO! This container does not contain the metasploit framework as there's issues with containers and
systemctl. You can download a python script that will provide you with emulation, or you can mess
with the Dockerfile. However, it's very finicky to get it to work. The create of Snotra has also got
a container which you can pull down for metasploit, OR you can dockerise it yourself from the Rapid7
github (I'd suggest the former due to the aliases provided):

- https://gitlab.com/snotra.uk/containers/metasploit-framework/-/tree/master?ref_type=heads
- https://github.com/rapid7/metasploit-framework/blob/master/Dockerfile

### Updates:

This is very much projects I tend to complete in my own time. If I have any updates they will be
provided whenever I finish them. I will also be trying to set up a GitHub actions workflow to allow
a push to here whenever I change anything.
