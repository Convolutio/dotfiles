#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p stow
stow nixfiles git bash latexmk wezterm
