{
  pkgs,
  lib,
  config,
  userSettings,
  ...
}:

{
  options = {
    shell.enable = lib.mkEnableOption "Enable Shell module";
  };
  
  config = lib.mkIf config.shell.enable {
    programs = {
      zsh = {
        enable = true;
        dotDir = ".config/zsh";
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        shellGlobalAliases = {
          g = "git";
          ga = "git add";
          gaa = "git add .";
          gb = "git branch";
          gc = "git commit";
          gcm = "git commit --message";
          gco = "git checkout";
          gd = "git diff";
          gi = "git init";
          gp = "git pull";
          gs = "git status";
          nb = "nix-build";
          nd = "nix develop";
          nr = "nix run";
          ns = "nix-shell";
          
	  ls = "exa -lha";
          vi = "nvim";
	  vim = "nvim";
      	  
	  c = "clear";
      	  q = "exit";
      
      	  nixrebuild = "sudo nixos-rebuild switch --flake " + "${userSettings.dotfilesDir}";
      	  nixupdate = "home-manager switch --flake " + "${userSettings.dotfilesDir}";
	  nixlist = "sudo nix-env -p /nix/var/nix/profiles/system --list-generations";
      	  nixdelete = "sudo nix-collect-garbage -d";
	};
	
	history = {
	  ignoreAllDups = true;
	  path = "${config.xdg.dataHome}/zsh/history";
	  save = 10000;
	  size = 10000;
	  share = true;
	};
	historySubstringSearch = {
	  enable = true;
	};
        
        plugins = with pkgs; [
        
	];
        
        oh-my-zsh = {
          enable = true;
	  plugins = [ 
            "sudo"
            "git"
            "docker"
            "colored-man-pages"
            "command-not-found"
            "history-substring-search"
          ];

          extraConfig = ''
	    export EDITOR='nvim'
            export TERMINAL='kitty'
            export BROWSER='firefox'
            export TERM="xterm-256color"
            
	    PROMPT='%F{blue}  %2~%f%F{gray} ∮%  '
	    
            function y() {
              local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
              yazi "$@" --cwd-file="$tmp"
              if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                builtin cd -- "$cwd"
              fi
                rm -f -- "$tmp"
            }
            
            ex () {
      	      if [ -f $1 ] ; then
                case $1 in
                  *.tar.bz2)   tar xjf $1   ;;
                  *.tar.gz)    tar xzf $1   ;;
                  *.bz2)       bunzip2 $1   ;;
                  *.rar)       ${pkgs.unrar}/bin/unrar x $1   ;;
                  *.gz)        gunzip $1    ;;
                  *.tar)       tar xf $1    ;;
                  *.tbz2)      tar xjf $1   ;;
                  *.tgz)       tar xzf $1   ;;
                  *.zip)       ${pkgs.unzip}/bin/unzip $1     ;;
                  *.Z)         uncompress $1;;
                  *.7z)        7z x $1      ;;
                  *.deb)       ar x $1      ;;
                  *.tar.xz)    tar xf $1    ;;
                  *.tar.zst)   tar xf $1    ;;
                  *)           echo "'$1' cannot be extracted via ex()" ;;
                esac
              else
                echo "'$1' is not a valid file"
              fi
            }
          '';
        };
      };
    };
    home.packages = [
      (pkgs.writeShellScriptBin "mk" ''
        mkdir -p $( dirname "$1") && touch "$1"
      '')
    ];
  };
}
