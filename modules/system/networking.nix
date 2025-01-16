{ 
  pkgs,
  systemSettings, 
  userSettings,
  ... 
}:

{
  networking = {
    hostName = systemSettings.hostname;
    networkmanager.enable = true;
  };

  environment.systemPackages = with pkgs; [
  networkmanagerapplet
  ];
  
  users.users.${userSettings.username}.extraGroups = [ "networkmanager" ];
}
