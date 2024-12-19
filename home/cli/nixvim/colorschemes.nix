{
  programs.nixvim = {
    colorschemes = {
      everforest.settings.transparent_background = 2;
      catppuccin = {
        enable = true;
        settings = {
          transparent_background = true;
        };
      };
    };
  };
}
