{
  inputs,
  pkgs,
  userSettings,
  ...
}: 

{
  home.username = userSettings.username;
  home.homeDirectory = userSettings.homeDirectory;
  home.sessionVariables = {
    EDITOR = userSettings.editor;
    #VISUAL = userSettings.editor;
    TERMINAL = userSettings.terminal;
    BROWSER = userSettings.browser;
  };
  home.enableNixpkgsReleaseCheck = false;
  home.stateVersion = "24.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [   
    ./apps
    ./cli
    ./system
  ];

  apps.enable = true;
  cli.enable = true;
  system.enable = true;
 
  home.packages = with pkgs; [
    
  ];

  # Add support for .local/bin
  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
