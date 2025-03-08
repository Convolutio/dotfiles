# Dotfiles

This repository contains software configuration settings for my personal Linux
distributions.

## Install this repository

Clone it in your home directory, with cloning its submodules

```sh
git clone --recurse-submodules git@github.com:Convolutio/dotgiles.git
# or
git clone git@github.com:Convolutio/dotfiles.git
cd dotfiles
git submodules init
git submodules update
```

## Apply the settings

To apply these settings, please install
[Stow](https://www.gnu.org/software/stow/).

Then, for each software, take its related directory <soft-dir> and run the
command

```sh
stow <soft-dir> # for example, $ stow wezterm
```

To remove the settings :

```sh
stow -D <soft-dir> # for example, $ stow -D wezterm
```
