{
  description = "System configuration";
  
  inputs = {
    etc-nixos = {
      url = "/etc/nixos";
      flake = false;
    };
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixvim = {
      url = "github:nix-community/nixvim/nixos-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs@{ self, etc-nixos, nixpkgs, home-manager, ...}:
  let
    # ---- SYSTEM SETTINGS ---- #
    systemSettings = {
      profile = "desktop"; # select a profile defined from my profiles directory
      hostname = "nixos";
      system = "x86_64-linux"; # system architecture
      timezone = "Europe/Moscow"; # select timezone
      locale = "ru_RU.UTF-8"; # select locale
      bootMode = if (systemSettings.profile == "desktop") then "uefi" else "bios"; # uefi or bios
      bootMountPath = if (systemSettings.bootMode == "bios") then "/boot" else "/boot/efi"; # mount path for efi boot partition; only used for uefi boot mode
      grubDevice = "nodev";
      gpuType = "intel"; # amd, intel or nvidia; only makes some slight mods for amd at the moment
    };

    # ----- USER SETTINGS ----- #
    userSettings = rec {
      username = "nebolsinvasili";  # username
      name = "nebolsinvasili";  # name
      email = "nebolsinvasili@gmail.com";  # email (used for certain configurations)
      homeDirectory = "/home/" + "${userSettings.username}/";
      dotfilesDir = "${userSettings.homeDirectory}" + "nixdots"; # absolute path of the local repo
      wm = "hyprland";  # Selected window manager or desktop environment [hyprland];
      # window manager type (hyprland or x11) translator	
      wmType = if ((wm == "hyprland") || (wm == "plasma")) then "wayland" else "X11";
      terminal = "kitty"; # Default terminal [ alacritty, kitty ];
      browser = "firefox";
      font = "JetBrains Mono"; # Selected font
      editor = "nvim"; # Default editor;
    };
    
    pkgs = import inputs.nixpkgs {
      system = systemSettings.system;
      config = {
        allowUnfree = true;
	allowUnfreePredicate = (_: true);
	allowBroken = true;
      };
    };
    lib = inputs.nixpkgs.lib;
    home-manager = inputs.home-manager;
    
  in {
    nixosConfigurations.${systemSettings.hostname} = lib.nixosSystem {
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
        # pass config variables from above
        inherit pkgs;
        inherit systemSettings;
        inherit userSettings;
        inherit inputs;
      };
    };
    
    homeConfigurations = {
      ${userSettings.username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
	  (./. + ("/home") + "/home.nix") # load home.nix from selected PROFILE
          inputs.nixvim.homeManagerModules.nixvim
        ];
	extraSpecialArgs = {
	  # pass config variables from above
          inherit pkgs;
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
	};
      };
    };
  };
}
