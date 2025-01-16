let
  # Pin to a specific nixpkgs commit for reproducibility.
  pkgs = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/24bb1b20a9a57175965c0a9fb9533e00e370c88b.tar.gz") {config.allowUnfree = true;};
in pkgs.mkShell {
  buildInputs = [
    pkgs.python311
    pkgs.python311Packages.torch-bin
    pkgs.python311Packages.unidecode
    pkgs.python311Packages.inflect
    pkgs.python311Packages.librosa
    pkgs.python311Packages.pip
  ];

  shellHook = ''
    echo "You are now using a NIX environment"
    export CUDA_PATH=${pkgs.cudatoolkit}
  '';
}
