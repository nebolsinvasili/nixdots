{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    yazi.enable = lib.mkEnableOption "Enable yazi module";
  };
  config = lib.mkIf config.yazi.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
