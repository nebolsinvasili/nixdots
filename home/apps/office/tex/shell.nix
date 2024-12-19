{ pkgs ? import <nixpkgs> {} }:
  let
    tex =
      pkgs.texlive.combine
        { inherit (pkgs.texlive) scheme-full pgf standalone;
        };
  in
    pkgs.mkShell
      { nativeBuildInputs =
        [ tex
        ];
      }
