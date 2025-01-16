{
  systemSettings,
  ...
}:

let
  bootMountPath = if (systemSettings.bootMode == "bios") then "/boot" else "/boot/efi";
  grubDevice = "nodev";
in {
  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  
  boot.loader.efi = {
    canTouchEfiVariables = if (systemSettings.bootMode == "bios") then false else true;
    efiSysMountPoint = bootMountPath;
  };
  
  boot.loader.grub = {
    enable = true;
    efiSupport = if (systemSettings.bootMode == "bios") then false else true;
    # efiInstallAsRemovable = if (systemSettings.bootMode == "bios") then false else true;
    device = grubDevice;
    useOSProber = true;
    default = 0;
  };
}
