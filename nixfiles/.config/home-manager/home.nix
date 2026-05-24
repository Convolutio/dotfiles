{
  config,
  pkgs,
  lazyvim,
  ...
}:

{
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

    # Just
    pkgs.just

    # Pixi
    pkgs.pixi

    # Typst
    pkgs.typst

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
  imports = [ lazyvim.homeManagerModules.default ];

  # ----------------- LazyVim -----------------
  programs.lazyvim = {
    enable = true;

    # Core LazyVim dependencies (git, ripgrep, fd, etc.)
    installCoreDependencies = true; # default: true

    # Load remaining config from lua files
    configFiles = ./lazyvim-config;

    extras = {
      lang = {
        nix = {
          enable = true;
          installDependencies = true;
        };
        python = {
          enable = true;
          installDependencies = false;
          installRuntimeDependencies = false;
        };
        markdown = {
          enable = true;
          installDependencies = true;
        };
        tex = {
          enable = true;
          installDependencies = true;
        };
        typst = {
          enable = true;
          installDependencies = true;
        };
        clangd = {
          enable = true;
          installDependencies = true;
        };
      };
    };

    # Manual parsers only needed for non-LazyVim languages
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter.grammarPlugins; [
      bash
    ];

    # Extra packages
    extraPackages = with pkgs; [
      statix
      pplatex
      clang-tools
      ruff
      pyright
    ];
  };

  # ----------------- Helix -----------------
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
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
          command = "${pkgs.tinymist}/bin/tinymist";
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
          language-servers = [ "tinymist" ];
        }
      ];
    };
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
    extraPackages = [
      pkgs.nil
      pkgs.nixfmt
      pkgs.ruff
      pkgs.ty
      pkgs.tinymist
    ];
  };
}
