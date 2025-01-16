{ 
  pkgs,
  systemSettings,
  userSettings,
  ...
}:

{
  imports = [
    ../default/configuration.nix
    
    ../../modules/system/nvidia.nix
    (../../. + "/modules" + "/wm" + ("/" + userSettings.wmType) + ".nix")
    (../../. + "/modules" + "/wm" + ("/" + userSettings.wm) + "/default.nix")
    
    ../../modules/programs
  ];
  
  environment.systemPackages = with pkgs; [
    telegram-desktop
  ];

  system.stateVersion = "24.11";
}
