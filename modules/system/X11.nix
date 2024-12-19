{
  pkgs, 
  ...
}: 

{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us, ru";
        variant = "";
      };
      displayManager.lightdm.enable=true;
    };
  };
}
