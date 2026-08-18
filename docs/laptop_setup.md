# Personal NixOS installation guide

1. Connect to the via wifi:

```sh
nmcli device wifi list
```

```sh
nmcli device wifi connect "SSID" password "PASS"
```

2. Partition the disks, create this hierarchy using btrfs.

- NIXROOT
    - root
    - home
    - nix
- NIXBOOT (512M)
- NIXDATA

3. Format the partitions:

```sh
sudo mkfs.fat -F 32 -n NIXBOOT /dev/nvme0n1p1
sudo mkfs.btrfs -L NIXROOT /dev/nvme0n1p2
sudo mkfs.btrfs -L NIXDATA /dev/sda1
```

4. Create subvolumes:

```sh
sudo mount /dev/disk/by-label/NIXROOT /mnt
sudo btrfs subvolume create /mnt/root
sudo btrfs subvolume create /mnt/home
sudo btrfs subvolume create /mnt/nix
sudo umount /mnt
```

5. Create the file system hierarchy:

```sh
sudo mount -o compress=zstd,subvol=root /dev/disk/by-label/NIXROOT /mnt
sudo mkdir -p /mnt/{boot,home,nix,data}
sudo mount /dev/disk/by-label/NIXBOOT /mnt/boot
sudo mount -o compress=zstd,subvol=home /dev/disk/by-label/NIXROOT /mnt/home
sudo mount -o compress=zstd,subvol=nix /dev/disk/by-label/NIXROOT /mnt/nix
sudo mount -o compress=zstd /dev/disk/by-label/NIXDATA /mnt/data
```

6. Generate nixos default files:

```sh
sudo nixos-generate-config --root /mnt
```

7. Install nixos:

```sh
sudo nixos-install
```
