{
  inputs,
  userSettings,
  ...
}:

{
  services.xserver = {
    enable = true;
    xkb = {
      layout = "us,ru";
      variant = "";
      options = "grp:win_space_toggle"; # Use Win+Space to toggle languages
    };
  };
  
  users.users.${userSettings.username}.extraGroups = [ "input" ];
}
