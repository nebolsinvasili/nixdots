{
  userSettings,
  ...
}:

{
  #services.xserver.displayManager.gdm.enable = true;

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = userSettings.username;
    defaultSession = userSettings.wm;
  };
  
  #services.getty.autologinUser = userSettings.username;

  #environment.loginShellInit = ''
  #dbus-run-session Hyprland
  #'';
}
