{
  lib,
  pkgs,
  config,
  ...
}: 

{
  options = {
    fonts.enable = lib.mkEnableOption "Enable fonts module";
    fonts.fontDir.enable = true;
  };
  
  config = lib.mkIf config.fonts.enable {
    home = {
      packages = with pkgs; [
        nerdfonts
        dejavu_fonts
        font-awesome
        fira-code-symbols
        material-design-icons
        noto-fonts
        powerline-symbols
      ];
    };
  };
}
