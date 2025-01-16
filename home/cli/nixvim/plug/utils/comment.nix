{
  pkgs,
  ...
}:

{
  programs.nixvim.plugins.comment-box = {
    enable = true;
  };
}
