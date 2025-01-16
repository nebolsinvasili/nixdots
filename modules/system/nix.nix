{
  nixpkgs,
  pkgs,
  userSettings,
  ...
}:

{
  nix = {
    package = pkgs.nix;

    settings = {
      experimental-features = [ "nix-command" "flakes" ];    
    };
    
    settings.auto-optimise-store = true;
    optimise.automatic = true;

    settings = {
      http-connections = 50;
      warn-dirty = false;
      log-lines = 50;
      sandbox = "relaxed";
      trusted-users = [
        "${userSettings.username}"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
      ];
    };
    
    gc = {
      automatic = false;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };
  
  # Allow non-root users to specify the allow_other or allow_root mount options.
  nixpkgs.config.allowUnfree = true;
  programs.fuse.userAllowOther = true;
  
  environment.systemPackages = with pkgs; [
    home-manager
  ];
}
