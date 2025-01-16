{
  description = "RStudio with custom R packages and additional tools";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      defaultPackage.x86_64-linux = pkgs.rstudioWrapper.override {
        packages = with pkgs.rPackages; [
          magick
          tesseract
          dplyr
          pander
          purrr
          tidyverse
          svglite
          yaml
          df2yaml
        ] ++ [
          pkgs.pandoc
          pkgs.texliveFull
        ];
      };
    };
}
