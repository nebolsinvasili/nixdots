{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    zotero.enable = lib.mkEnableOption "Enable zotero module";
  };
  config = lib.mkIf config.zotero.enable {
    home.packages = with pkgs; [
    zotero
    ];
  };
}
