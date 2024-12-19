{
  lib,
  config,
  ...
}:

{
  imports = [
    
  ];

  options = {
    system.enable = lib.mkEnableOption "Enable system module";
  };
  
  config = lib.mkIf config.system.enable {
    
  };
}
