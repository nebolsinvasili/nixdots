{
  description = "Hyprland configuration";

  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs-unstable }:
    let
      pkgs = import nixpkgs-unstable { system = "x86_64-linux"; };
    in
    {
      packages.x86_64-linux.hyprland = pkgs.stdenv.mkDerivation {
        name = "hyprland-config";
        src = ./.;
        buildInputs = [
          pkgs.hyprland
          pkgs.wlroots
        ];
      };
    };
}
