{
  pkgs,
  ...
}:

{
  gtk = {
    enable = true;
    theme = {
      name = "Whitesur-Dark";
      package = pkgs.whitesur-gtk-theme.override {
        altVariants = ["normal"]; # default: normal
        colorVariants = ["Dark"]; # default: all
        opacityVariants = ["normal"]; # default: all
        themeVariants = ["default"]; # default: default (BigSur-like theme)
        iconVariant = "tux"; # default: standard (Apple logo)
        nautilusStyle = "stable"; # default: stable (BigSur-like style)
        nautilusSize = "default"; # default: 200px
        panelOpacity = "default"; # default: 15%
        panelSize = "default"; # default: 32px
        roundedMaxWindow = true; # default: false
        nordColor = false; # default = false
        darkerColor = true; # default = false
      };
    };
    iconTheme = {
      name = "Whitesur";
      package = pkgs.whitesur-icon-theme.override {
        themeVariants = ["default"];
        boldPanelIcons = true;
        alternativeIcons = true;
      };
    };
    cursorTheme= {
      name = "capitaine-cursors";
      package = pkgs.capitaine-cursors;
      size = 24;
    };
    font = {
      package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
      name = "JetBrainsMono";
      size = 10;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
  };
}
