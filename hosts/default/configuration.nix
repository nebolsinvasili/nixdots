{ 
  lib,
  pkgs,
  systemSettings,
  userSettings,
  ...
}:

{
  imports = [
    ../../modules/system
  ];

  users.users = {
    ${userSettings.username} = {
      isNormalUser = true;
      description = userSettings.username;
      shell = pkgs.zsh;
      extraGroups = [
        "wheel"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    neofetch
    wget
    vim 
    ranger
    htop
    kitty
  ];

  system.stateVersion = lib.mkDefault "24.11";
}
