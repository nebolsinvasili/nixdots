{
  pkgs,
  userSettings,
  ...
}:

{
  hardware.pulseaudio.enable = false;
  
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
        enable = true;
        support32Bit = true;
    };
    wireplumber.enable = true;
    jack.enable = true;
    pulse.enable = true;
    audio.enable = true;
  };
  
  users.users.${userSettings.username}.extraGroups = [ "audio" ];

  environment.systemPackages = with pkgs;[
    pavucontrol
  ];
}
