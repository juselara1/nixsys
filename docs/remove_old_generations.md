# Remove Old Generations
---

## User Level
---

1. To list generations:

    ```sh
    nix-env --list-generations
    ```

1. To remove generations:

    ```sh
    nix-collect-garbage --delete-old
    ```

## System Level
---

1. To list generations:

    ```sh
    sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
    ```

1. To delete generations:

    ```sh
    sudo nix-collect-garbage -d
    ```

1. To remove entries from boot:

    ```sh
    sudo /run/current-system/bin/switch-to-configuration boot
    ```
