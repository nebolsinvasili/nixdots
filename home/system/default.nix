{
  lib,
  config,
  ...
}:

{
  imports = [
    ./shell
    ./gtk.nix
    ./fonts
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  
  config = lib.mkIf config.system.enable {
    shell.enable = lib.mkDefault true;
    fonts.enable = lib.mkDefault true;
  };
}
