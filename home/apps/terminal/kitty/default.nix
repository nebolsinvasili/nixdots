{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    kitty.enable = lib.mkEnableOption "Enable kitty module";
  };
  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      extraConfig = builtins.readFile ./kitty.conf;
    };
    home.file."${config.home.homeDirectory}/.config/kitty/colors" = { source = ./colors; recursive = true; };
  };

}
