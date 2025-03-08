# Dotfiles

This repository contains software configuration settings for my personal Linux
distributions.

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
