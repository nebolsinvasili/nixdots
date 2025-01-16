{
  lib,
  config,
  nixvim,
  ...
}: {
  imports = [
    ./bat
    ./eza
    ./yazi
    ./fd
    ./fzf
    ./tmux
    ./nixvim
    ./direnv
    ./git
    ./ssh
  ];

  options = {
    cli.enable = lib.mkEnableOption "Enable cli module";
  };
  config = lib.mkIf config.cli.enable {
    bat.enable = lib.mkDefault true;
    eza.enable = lib.mkDefault true;
    yazi.enable = lib.mkDefault true;
    fd.enable = lib.mkDefault true;
    fzf.enable = lib.mkDefault true;
    tmux.enable = lib.mkDefault true;
    nixvim.enable = lib.mkDefault true;
    direnv.enable = lib.mkDefault true;
    git.enable = lib.mkDefault true;
    ssh.enable = lib.mkDefault true;
  };
}
