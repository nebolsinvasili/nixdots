{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    tex.enable = lib.mkEnableOption "Enable tex module";
  };
  config = lib.mkIf config.tex.enable {
    home.packages = with pkgs; [
      texliveFull
      texstudio
    ];
  };
}
