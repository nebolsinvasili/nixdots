{
  pkgs,
  lib,
  config,
  ...
}:
let
  tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tmux-sessionx";
      version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner = "omerxx";
        repo = "tmux-sessionx";
        rev = "4e71ae515497a09401d84e75d6dcede4cf1b178f";
        sha256 = "sha256-Ig6+pB8us6YSMHwSRU3sLr9sK+L7kbx2kgxzgmpR920=";
      };
    };
  tmux-floax = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tmux-floax";
     version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner = "omerxx";
        repo = "tmux-floax";
        rev = "f7a4adfeb055e1b1d268d7484de8362f242bd11e";
        sha256 = "sha256-Ig6+pB8us6YSMHwSRU3sLr9sK+L7kbx2kgxzgmpR920=";
      };
    };
  catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "catppuccin-tmux";
      version = "unstable-2023-01-06";
      src = pkgs.fetchFromGitHub {
        owner = "omerxx";
        repo = "catppuccin-tmux";
        rev = "e30336b79986e87b1f99e6bd9ec83cffd1da2017";
        sha256 = "sha256-Ig6+pB8us6YSMHwSRU3sLr9sK+L7kbx2kgxzgmpR920=";
      };
  };
in {
  options = {
    tmux.enable = lib.mkEnableOption "Enable tmux module";
  };
  config = lib.mkIf config.tmux.enable {
    programs.tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      extraConfig = builtins.readFile ./tmux.conf;
      plugins = with pkgs.tmuxPlugins; [
        sensible
        yank
        tmux-thumbs
        tmux-fzf
        fzf-tmux-url
        vim-tmux-navigator
        {
          plugin = catppuccin;
	  extraConfig = ''
            set -g @catppuccin_status_background "default"

            set -g @catppuccin_window_left_separator " "
            set -g @catppuccin_window_right_separator ""
            set -g @catppuccin_window_middle_separator " █"
      	    set -g @catppuccin_window_number_position "right"
      	    set -g @catppuccin_window_default_fill "number"
      	    set -g @catppuccin_window_default_text "#W"
      	    set -g @catppuccin_window_current_fill "number"
      	    set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
      	    set -g @catppuccin_status_modules_right "directory meetings date_time"
      	    set -g @catppuccin_status_modules_left "session"
      	    set -g @catppuccin_status_left_separator  " "
      	    set -g @catppuccin_status_right_separator ""
      	    set -g @catppuccin_status_right_separator_inverse "no"
      	    set -g @catppuccin_status_fill "icon"
      	    set -g @catppuccin_status_connect_separator "no"
      	    set -g @catppuccin_directory_text "#{b:pane_current_path}"
      	    set -g @catppuccin_meetings_text "#($HOME/.config/tmux/scripts/cal.sh)"
      	    set -g @catppuccin_date_time_text "%H:%M"
	    set -g @catppuccin_icon_window_last "󰖰"
	    set -g @catppuccin_icon_window_current "󰖯"
	    set -g @catppuccin_icon_window_zoom "󰁌"
	    set -g @catppuccin_icon_window_mark "󰃀"
	    set -g @catppuccin_icon_window_silent "󰂛"
	    set -g @catppuccin_icon_window_activity "󱅫"
	    set -g @catppuccin_icon_window_bell "󰂞"
      	  '';
        }
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
          '';
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
          '';
        }
      ];
    };

    home.packages = with pkgs; [
      tmux-sessionizer
      (writeShellScriptBin "tmux-sessionizer-script" ''
        if [[ $# -eq 1 ]]; then
            selected=$1
        else
            selected=$(find ~/projects ~/tests ~/ztm -mindepth 1 -maxdepth 1 -type d | fzf)
        fi

        if [[ -z $selected ]]; then
            exit 0
        fi

        selected_name=$(basename "$selected" | tr . _)
        tmux_running=$(pgrep tmux)

        if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
            tmux new-session -s $selected_name -c $selected
            exit 0
        fi

        if ! tmux has-session -t=$selected_name 2> /dev/null; then
            tmux new-session -ds $selected_name -c $selected
        fi

        if [[ -z $TMUX ]]; then
            nvim "$selected"
            tmux kill-session -t $selected_name
        else
            nvim "$selected"
            tmux kill-session -t $selected_name
        fi
        '')
      ];
      home.file."${config.xdg.configHome}/tmux/tmux.reset.conf" = {
        source = ./tmux.reset.conf;
        recursive = true;
      };
      home.file."${config.xdg.configHome}/tmux/scripts/cal.sh" = {
        source = ./scripts/cal.sh;
        recursive = true;
      };
    };
}
