{
  pkgs,
  ...
}:

{
  services.timesyncd.enable = true;
  
  # Enable CUPS to print documents.
  services.printing.enable = true;
  
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
