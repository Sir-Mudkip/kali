## Overview

This is a Kali container with almost every tool I can think of. This includes most of your general tools you'd likely use for pentesting of web apps, cloud, networks, and some wireless support.

***Please do not use this container for destructive or illegal activities!!!!***

### Credit:

I did not build the structure to this container file. The credit must go to my colleague and cloud hacking guru ["Shaunography"](https://gitlab.com/shaunography), creator of Snotra. Please find the links below:

- https://snotra.uk/
- https://gitlab.com/snotra.uk
- https://gitlab.com/snotra.cloud

This is just a project of mine that I want to do to get used to making some Dockerfiles, modifying them, and using github actions workflows for CI/CD. I have added a few of my own tools to this that I tend to use on a more frequent basis such as:
- testssl
- NoPrompt
- Linkedin-dumper

There's a few more I'm not thinking of but those are the main ones that come to mind. This also comes with my own personal keybinds and plugins for neovim and tmux. I will likely change the container a little bit as new tools come out. 

I've also changed a few things to make the file more pullable such as a dedicate brewfile for brew installs. I will try make more optimisatons in future to reduce the number of layers and if I can install something via brew then I will to avoid the packages conflicting with system packages like in `apt`.
The other thing to note is that I also removed John the Ripper for password cracking as I have a separate container containing hashcat with dedicated GPU Passthru. Hashcat should be installed however if you want to use it.

### Install:

```bash
docker pull ghcr.io/sir-mudkip/kali:latest
```
```bash
sudo podman pull ghcr.io/sir-mudkip/kali:latest
```

### Alias:

I suggest that you run the following command to run the container:
```bash
kali() {
    sudo podman run \
    -it \
    --rm \
    --security-opt label=disable \
    --network host \
    --privileged \
    -v $HOME:/run/host \
    ghcr.io/sir-mudkip/kali:latest
}
```

- If using docker, replace the podman command with docker (make sure to run as sudo!)
- `--security-opt` is the required if SELinux is enabled
- `--privileged` is for low level network access
- `--netowork host` for catching shells
- To enable GPU passthrough and use hashcat in the container, then add `--gpus all \` into the command before the image name.

> [!NOTE] GPU
> To use tools like hashcat in this container, you will need the Nvidia drivers and the Nvidias container toolkit to enable GPU passthru. The CUDA toolkit can be installed in the container and if you enable passthru it should just work.
> I have not included the toolkit to save space and efficiency, though if you would like to include it you can go [here](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Debian&target_version=12&target_type=deb_local) and build a RUN layer for each of the steps here. I personally would suggest a dedicated hashcat image which is a WIP for myself.

I don't recommend using hashcat in this container as it's already quite big. I have an ongoing project which will seek to make a hashcat container more usable.

ALSO! msfconsole doesn't work in this as there's issues with containers and systemctl in trying to get it to work. You can download a python script that will provide you with emulation, or you can mess with the Dockerfile where you can enable things like Apache.

You can alternatively change the CMD in the Dockerfile to `/sbin/init`, run the container, then run `podman exec -it kali bash` which will give systemd status options. I have not tried this personally, but this makes the container behave a little bit more like a VM.

The creater of Snotra has also got a container which you can pull down for metasploit, OR you can dockerise it yourself from the Rapid7 github (I'd suggest the former due to the aliases provided):

- https://gitlab.com/snotra.uk/containers/metasploit-framework/-/tree/master?ref_type=heads
- https://github.com/rapid7/metasploit-framework/blob/master/Dockerfile

Other metasploit utilities such as msfvenom are available and will work.

### Updates:

This is very much a project I tend to work on in my own time. If I have any updates they will be provided whenever I finish them. I will also be trying to set up a GitHub actions workflow to allow a push to here whenever I change anything.
