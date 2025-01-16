{pkgs, lib, userSettings, ...}:
{

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    #enableNvidia = true;
    storageDriver = "btrfs";
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
    autoPrune.enable = true;
  };
  users.users.${userSettings.username}.extraGroups = [ "docker" ];
  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker
  ];

}
