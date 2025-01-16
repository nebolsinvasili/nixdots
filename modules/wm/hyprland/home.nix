{ 
  inputs,
  lib,
  config,
  pkgs,
  systemSettings,
  userSettings,
  ... 
}: 

{
  imports = [
    ./program/cmus
  ];

  xdg.portal = {
    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  };

  home.packages = with pkgs; [
    waybar
    wofi
    wl-clipboard
    cliphist
    hyprpaper
    grim slurp
    jq
  ];
  
  cmus.enable = lib.mkDefault true;
  
  home.file."${config.xdg.configHome}/hypr/themes/" = {
    source = ./themes;
    recursive = true;
  };
  home.file."${config.home.homeDirectory}/wallpapers/" = {
    source = ./wallpapers;
    recursive = true;
  };
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${systemSettings.system}.hyprland;
    xwayland.enable = true;
    extraConfig = ''
    ${builtins.readFile ./configs/hypr_work.conf}
    '';
  };
}
