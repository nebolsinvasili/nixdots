{ lib, config, ... }:
{
  imports = [
    ./terminal/alacritty
    ./terminal/kitty
    ./brouser/firefox
    ./brouser/chrome
    ./office/tex
    #./office/zotero
    ./development/vscode
  ];

  options = {
    apps.enable = lib.mkEnableOption "Enable apps module";
  };
  config = lib.mkIf config.apps.enable {
    alacritty.enable = lib.mkDefault false;
    kitty.enable = lib.mkDefault true;
    firefox.enable = lib.mkDefault false;
    chrome.enable = lib.mkDefault true;
    tex.enable = lib.mkDefault true;
    #zotero.enable = lib.mkDefault true;
    vscode.enable = lib.mkDefault true;
  };
}
