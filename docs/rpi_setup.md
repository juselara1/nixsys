# Raspberry Installation Intstructions
---

1. Download raspberry image and flash it into the microsd card:

    ```sh
    zstd -dc nixos-image-sd-card-26.05.8255.a9e6d84f9c2f-aarch64-linux.img.zst | sudo dd of=/dev/sdc bs=256M status=progress conv=fsync
    ```

1. Plug the SD card into the device and turn it on, this allows creating the default settings.
1. Identify the root partition and mount it in another computer.

    ```sh
    sudo mount /dev/sdc2 mnt
    ```

1. Generate ssh-keys, update local config and add the `.pub` file into `/home/nixos/.ssh/authorized_keys`.
1. Download this repo in the **builder** machine, and build:

    ```sh
    nixos-rebuild switch --flake .#pihole
    ```

    If the device doesn't have enough memory to build, use another machine and remotely build:

    ```sh
    nixos-rebuild switch --flake .#pihole --target-host ${TARGET} --sudo
    ```
