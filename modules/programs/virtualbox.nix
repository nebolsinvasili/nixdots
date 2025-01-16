{
  userSettings,
  ...
}:

{
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.guest.enable = true;
  users.extraGroups.vboxusers.members = [ "${userSettings.username}" ];
}
