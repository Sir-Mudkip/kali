## Overview

This is a Kali container with tools I use daily when pentesting. This is designed to be a disposable container you can spin up and spin down when you want to do quick tasks. A more longstanding and systemd supported container is in dev which will also contain cloud tools.

I have made this image as a base image which can be built upon for your own purposes. You can do this in a Containerfile with:
```Dockerfile
FROM ghcr.io/sir-mudkip/kali:base AS base
```

### Install:

```bash
sudo podman pull ghcr.io/sir-mudkip/kali:base
```
If using docker then replace podman with docker. Both work as they are OCI compliant.

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
    ghcr.io/sir-mudkip/kali:base
}
```

- If using docker, replace the podman command with docker
- `--security-opt` is the required if SELinux is enabled
- `--privileged` is for low level network access
- `--netowork host` for catching shells
- You can update the mount to your desired directory.

> [!NOTE] GPU
> To use tools like hashcat in this container, you will need the Nvidia drivers and the Nvidias container toolkit to enable GPU passthru. The CUDA toolkit can be installed in the container and if you enable passthru it should just work.
> I have not included the toolkit to save space and efficiency, though if you would like to include it you can go [here](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Debian&target_version=12&target_type=deb_local) and build a dedicated .sh file for install. I personally would suggest a dedicated hashcat image which is a WIP.

I don't recommend using hashcat in this container as it's already quite big. I have an ongoing project which will seek to make a hashcat container more usable.

### Systemd Services:

msfconsole and other systemd services like docker, apache, etc, don't work in this image per se as there's issues with containers and systemctl when the cmd that builds the container is /bin/bash. Stuff like msfvenom as a utility will work, but I don't recommend using this container to run these things. As I said at the top, systemd is a work in progress right now and will likely be in a dedicated cloud image.  


### Credit:

I did not build the structure to this container file. The credit must go to my colleague and cloud hacking guru ["Shaunography"](https://gitlab.com/shaunography), creator of Snotra. Please find the links below:

- https://snotra.uk/
- https://gitlab.com/snotra.uk
- https://gitlab.com/snotra.cloud

The creater of Snotra has also got a containers which you can pull down for metasploit, OR you can dockerise it yourself from the Rapid7 github (I'd suggest the former due to the aliases provided):

- https://gitlab.com/snotra.uk/containers/metasploit-framework/-/tree/master?ref_type=heads
- https://github.com/rapid7/metasploit-framework/blob/master/Dockerfile
