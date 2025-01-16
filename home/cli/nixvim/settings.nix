{ 
  pkgs,
  ...
}:

{
  programs.nixvim = {
	  performance = {
	    byteCompileLua = {
	      enable = true;
	      nvimRuntime = true;
	      configs = true;
	      plugins = true;
	    };
	  };
	  clipboard = {
	    # Use system clipboard
	    register = "unnamedplus";

	    providers = {
	      wl-copy = {
		      enable = true;
		      package = pkgs.wl-clipboard;
	      };
	    };
	  };

	  globals = {
		# Set <space> as the leader key
		mapleader = " ";
		maplocalleader = " ";

		# Set to true if you have a Nerd Font installed and selected in the terminal
		have_nerd_font = true;
	      };
	  
	  opts = {
	    # Enable relative line numbers
	    number = false;
	    relativenumber = true;

	    # Set tabs to 2 spaces
	    tabstop = 2;
	    softtabstop = 2;
	    showtabline = 2;
	    expandtab = true;

	    # Enable auto indenting and set it to spaces
	    smartindent = true;
	    shiftwidth = 2;

	    # Enable smart indenting (see https://stackoverflow.com/questions/1204149/smart-wrap-in-vim)
	    breakindent = true;

	    # Enable incremental searching
	    hlsearch = true;
	    incsearch = true;

	    # Enable text wrap
	    wrap = true;

	    # Better splitting
	    splitbelow = true;
	    splitright = true;

			# Preview subsitutions live, as you type!
	    inccommand = "split";

	    # Enable mouse mode
	    mouse = "a"; # Mouse
			mousefocus = true;

	    # Enable ignorecase + smartcase for better searching
	    ignorecase = true;
	    smartcase = true; # Don't ignore case with capitals
	    grepprg = "rg --vimgrep";
	    grepformat = "%f:%l:%c:%m";

	    # Decrease updatetime
	    updatetime = 50; # faster completion (4000ms default)

	    # Set completeopt to have a better completion experience
	    completeopt = [
	      "menuone"
	      "noselect"
	      "noinsert"
	    ]; # mostly just for cmp

	    # Enable persistent undo history
	    swapfile = false;
	    autoread = true;
	    backup = false;
	    undofile = true;

	    # Enable 24-bit colors
	    termguicolors = true;

	    # Enable the sign column to prevent the screen from jumping
	    #signcolumn = "yes";

	    # Enable cursor line highlight
	    cursorline = true; # Highlight the line where the cursor is located

	    # Set fold settings
	    # These options were reccommended by nvim-ufo
	    # See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
	    foldcolumn = "0";
	    foldlevel = 99;
	    foldlevelstart = 99;
	    foldenable = true;

	    # Always keep 8 lines above/below cursor unless at start/end of file
	    scrolloff = 10;

	    # Place a column line
	    # colorcolumn = "80";

	    # Reduce which-key timeout to 10ms
	    timeoutlen = 10;

	    # Set encoding type
	    encoding = "utf-8";
	    fileencoding = "utf-8";

	    # More space in the neovim command line for displaying messages
	    cmdheight = 0;

	    # We don't need to see things like INSERT anymore
	    showmode = true;
    };
  };
}