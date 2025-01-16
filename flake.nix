{
  description = "Nix system configuration";
  
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    etc-nixos = {
      url = "/etc/nixos";
      flake = false;
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, etc-nixos, disko, ... }:
  let
  # ---- SYSTEM SETTINGS ---- #
  systemSettings = {
    profile = "desktop";
    hostname = "nixos";
    system = "x86_64-linux";
    timezone = "Europe/Moscow";
    locale = "ru_RU.UTF-8";
    bootMode = if (systemSettings.profile == "desktop") then "uefi" else "bios";
    gpuType = "intel";
  };
  # ----- USER SETTINGS ----- #
  userSettings = rec {
    username = "nebolsinvasili";
    name = "Nebolsin Vasili";
    email = "nebolsinvasili@gmail.com";
    homeDir = "/home/" + "${userSettings.username}/";
    dotfilesDir = "${userSettings.homeDir}" + "nixdots";
    
    wm = "hyprland";
    wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "x11";
    
    terminal = "kitty";
    browser = "firefox";
    font = "JetBrains Mono";
    editor = "nvim";
  };

  pkgs = import nixpkgs {
    system = systemSettings.system;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      allowBroken = true;
      cudaSupport = true;
    };
  };

  in {
    nixosConfigurations.${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
      system = systemSettings.system;
      modules = [
        {
          imports = if (builtins.pathExists "${etc-nixos}/hardware-configuration.nix")
          then [ (import "${etc-nixos}/hardware-configuration.nix") ]
          else [];
            assertions = [
              {
                assertion = builtins.pathExists "${etc-nixos}/hardware-configuration.nix";
                message = "The hardware-configuration file is missing at ${etc-nixos}/hardware-configuration.nix";
              }
            ];
        }
        (./. + "/hosts" + ("/" + systemSettings.profile) + "/configuration.nix")
        home-manager.nixosModules.default
      ];
      specialArgs = {
        inherit pkgs;
        inherit systemSettings;
        inherit userSettings;
        inherit inputs;
      };
    };

    homeConfigurations.${userSettings.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        (./. + ("/home") + "/home.nix")
        inputs.nixvim.homeManagerModules.nixvim
      ];
      extraSpecialArgs = {
        inherit pkgs;
        inherit systemSettings;
        inherit userSettings;
        inherit inputs;
      };
    };
  };
}
