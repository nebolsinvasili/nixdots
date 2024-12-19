{ 
  pkgs,
  systemSettings,
  userSettings,
  ...
}:

{
  imports = [
    ../default/configuration.nix
    ../../modules/programs
    ../../modules/desktop
  ];
  
  environment.systemPackages = with pkgs; [
    
  ];

  system.stateVersion = "24.11";
}
