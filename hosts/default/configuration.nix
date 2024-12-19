{ 
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:

{
  imports = [
    ../../modules/nix.nix
    ../../modules/system
    ../../modules/services.nix
  ];

  users.users = {
    ${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.username;
      initialPassword = "qwerty";
      shell = pkgs.zsh;
      extraGroups = [
        "networkmanager"
        "wheel"
        "input"
      ];
    };
  };
  
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    neofetch
    wget
  ];

  system.stateVersion = lib.mkDefault "24.11";
}
