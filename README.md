# Dotfiles

This repository contains software configuration settings for my personal Linux
distributions.

## Install this repository

Clone it in your home directory, with cloning its submodules

```sh
git clone --recurse-submodules git@github.com:Convolutio/dotfiles.git
# or
git clone git@github.com:Convolutio/dotfiles.git
cd dotfiles
git submodules init
git submodules update
```

## Apply the settings

1. [Install `nix`](https://nix.dev/install-nix) (in multi-user or single-user mode)
2. Run this reproducible script

   ```sh
   ./install-home-config.sh
   nix run home-manager/master -- switch
   ```

3. You can toggle the dotfiles with the now-installed
   [`stow`](https://www.gnu.org/software/stow/) package

   Then, for each software, take its related directory <soft-dir> and run the
   command

   ```sh
   stow <soft-dir> # for example, $ stow wezterm
   ```

   To remove the settings :

   ```sh
   stow -D <soft-dir> # for example, $ stow -D wezterm
   ```
