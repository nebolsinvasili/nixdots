{
  pkgs, 
  ...
}: 

{
  services.xserver.desktopManager.gnome = {
    enable = true;
  };

  programs.dconf.enable = true;
} 
