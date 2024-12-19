{ 
  lib,
  config,
  pkgs,
  userSettings,
  ...
}:

{
  options = {
    ssh.enable = lib.mkEnableOption "Enable ssh module";
  };
  config = lib.mkIf config.ssh.enable { 
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/id_ed25519";
        };
      };
    };
  };
}
