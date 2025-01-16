{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cmus.enable = lib.mkEnableOption "Enable cmus module";
  };
  config = lib.mkIf config.cmus.enable {
    programs.cmus = {
      enable = true;
      extraConfig = ''
         ${builtins.readFile ./autosave}
      '';
    };
  };
}
