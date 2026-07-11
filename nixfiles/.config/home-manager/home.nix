{
  config,
  pkgs,
  ...
}:

{
  nixpkgs.config.allowUnfree = true; # for discord and other sources
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "thormas";
  home.homeDirectory = "/home/thormas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    pkgs.stow
    pkgs.tmux
    pkgs.xclip
    pkgs.keepassxc
    pkgs.gitg
    pkgs.chafa
    pkgs.inkscape
    pkgs.gimp

    # Just
    pkgs.just

    # Pixi
    pkgs.pixi

    # Typst
    pkgs.typst

    # Dev env management (system deps, language deps, processes, tasks, secrets)
    pkgs.mise

    pkgs.joplin-desktop
    pkgs.discord

    # Lsp available at home scope
    pkgs.tinymist
    pkgs.ruff
    pkgs.ty
    pkgs.ltex-ls-plus
    pkgs.texlab
    pkgs.bibtex-tidy

    #   Web stack
    pkgs.typescript
    pkgs.typescript-language-server
    pkgs.astro-language-server
    pkgs.svelte-language-server
    # WARN: this npm global plugin should be installed
    # pkgs.typescript-svelte-plugin

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/thormas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    TERMINAL = "wezterm";
  };
  home.sessionPath = [
    "$HOME/.nix-profile/bin"
    "$HOME/bin"
    "$HOME/.local/bin"
    "$HOME/.pixi/bin"
  ];
  # Let Home Manager manage the shell
  # Zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
      theme = "robbyrussell";
    };
    initContent = ''
      # pixi completions
      autoload -Uz compinit && compinit  # redundant with Oh My Zsh
      eval "$(pixi completion --shell zsh)"
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Imports
  imports = [ ];

  # ----------------- Helix -----------------
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        soft-wrap.enable = true;
        rulers = [ 81 ]; # no wrapped line will touch the column bar
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
      keys.normal = {
        "A-q" = ":reflow";
      };
      keys.select = {
        "A-q" = ":reflow";
      };
    };
    languages = {
      language-server = {
        ruff = {
          command = "ruff"; # the home's ruff or the project-local ruff, if existing
          args = [ "server" ];
        };
        ty = {
          command = "ty";
          args = [ "server" ];
          config = {
            inlayHints.callArgumentNames = false;
            experimental.rename = true;
            experimental.autoImport = true;
          };
        };
        tinymist = {
          command = "tinymist"; # tinymist shall be sourced in the path
        };
        ltex-ls-plus.config = {
          # WARN: when ltex-ls-plus will be updated on nixpkgs, be careful to
          # change "fr" to "fr-FR"
          ltex.ltex-ls.logLevel = "warning";
          ltex.diagnosticSeverity = "warning";
          ltex.disabledRules = {
            "en-US" = [ "PROFANITY" ];
            "en-GB" = [ "PROFANITY" ];
          };
          ltex.dictionary = {
            "en-US" = [ "builtin" ];
            "en-GB" = [ "builtin" ];
            "fr" = [ "builtin" ];
          };
        };
        astro-ls = {
          command = "astro-ls";
          args = [ "--stdio" ];
          config = {
            typescript = {
              tsdk = "${pkgs.typescript}/lib";
            };
            environment = "node";
          };
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "python";
          language-servers = [
            "ruff"
            "ty"
          ];
          auto-format = true;
        }
        {
          # https://myriad-dreamin.github.io/tinymist/frontend/helix.html
          name = "typst";
          language-servers = [
            "tinymist"
            "ltex-ls-plus"
          ];
        }
        {
          name = "markdown";
          language-servers = [
            "marksman"
            "ltex-ls-plus"
          ];
        }
        {
          name = "astro";
          auto-format = true;
          language-servers = [ "astro-ls" ];
        }
      ];
    };
    extraPackages = [
      pkgs.nil
      pkgs.nixfmt
      pkgs.marksman
    ];
  };
}
