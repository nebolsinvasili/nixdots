{
  inputs,
  pkgs,
  config,
  userSettings,
  ...
}: 

{
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDir;
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    TERMINAL = userSettings.terminal;
    BROWSER = userSettings.browser;
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    (../. + "/modules" + "/wm" + ("/" + userSettings.wm) + "/home.nix")
    ./apps
    ./cli
    ./system
  ];

  apps.enable = true;
  cli.enable = true;
  system.enable = true;
 
  home.packages = with pkgs; [
    qbittorrent
  ];
  
  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
