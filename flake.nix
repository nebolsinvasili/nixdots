{
  description = "NixOS configuration";
  # All inputs for the system
  inputs = {
    inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Editors
    ## NixVim
    nixvim = {
      url = "github:nix-community/nixvim";
      nixvim.inputs.nixpkgs.follows = "nixpkgs";
    };

    # Uniform color across all apps
    catppuccin.url = "github:catppuccin/nix";
  };
  
  # All outputs for the system (configs)
  outputs = {self, nixpkgs, home-manager, ...}@inputs:
  let
    # Supported systems for flake packages, shell, etc.
    systems = [
      "x86_64-linux"
    ];
      # This is a function that generates an attribute by calling a function you
      # pass to it, with each system as an argument
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {

    };
  };
    
}