{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    alacritty.enable = lib.mkEnableOption "Enable alacritty module";
  };
  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = fromTOML (builtins.readFile ./alacritty.toml);
    };
    
  };

}
