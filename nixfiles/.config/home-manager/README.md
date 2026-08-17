# Nix config

## Disk-storage friendly home

Always clear the nix store parts related to the older generations.

```sh
home-manager expire-generations '-2 days' && \
  nix-collect-garbage && \
  nix-collect-garbage -d
```

## TODO
- [] automatize that with the config
