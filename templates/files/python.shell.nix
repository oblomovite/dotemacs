{ pkgs ? import (fetchTarball https://git.io/Jf0cc) {} }:

let
  mach-nix = import (
    builtins.fetchGit {
      url = "https://github.com/DavHau/mach-nix/";
      ref = "2.0.0";
    }
  );

  customPython = mach-nix.mkPython {
    python = pkgs.python38;
    requirements = ''
      grpclib==0.3.1
    '';
  };
in

pkgs.mkShell {
  buildInputs = [ customPython ];
}
