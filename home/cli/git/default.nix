{ lib, config, pkgs, userSettings, ... }:

{
  options = {
    git.enable = lib.mkEnableOption "Enable git module";
  };
  config = lib.mkIf config.git.enable { 
    programs.git = {
      enable = true;
      userName = userSettings.name;
      userEmail = userSettings.email;
      extraConfig = {
        init.defaultBranch = "master";
        safe.directory = [ userSettings.dotfilesDir
                           (userSettings.dotfilesDir + "/.git") ];
      };
    };
  };
}
