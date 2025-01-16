{
  inputs,
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    nixvim.enable = lib.mkEnableOption "Enable nixvim module";
  };
  config = lib.mkIf config.nixvim.enable {
    programs.nixvim.enable = true;
  };
  imports = [
    ./colorschemes.nix
    ./settings.nix
    ./plug/utils/comment.nix
  ];
}
