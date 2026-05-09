{
  description = "Home Manager configuration of thormas";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # WezTerm
    nixgl.url = "github:nix-community/nixGL";
    # LazyVim
    lazyvim.url = "github:pfassina/lazyvim-nix";
  };

  outputs =
    inputs @ { nixpkgs, home-manager, nixgl, lazyvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ nixgl.overlay ];
      };
    in
    {
      homeConfigurations."thormas" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          { imports = [ lazyvim.homeManagerModules.default ]; }
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
