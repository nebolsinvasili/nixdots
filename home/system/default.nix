{
  lib,
  config,
  ...
}:

{
  imports = [
    ./fonts
    ./shell
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  
  config = lib.mkIf config.system.enable {
    fonts.enable = lib.mkDefault true;
    shell.enable = lib.mkDefault true;
  };
}
