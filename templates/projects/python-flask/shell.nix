
# { sources ? import ./sources.nix }:     # import the sources
# with
#   { overlay = _: pkgs:
#       { niv = (import sources.niv {}).niv;    # use the sources :)
#       };
#   };
# import sources.nixpkgs                  # and use them again!
#   { overlays = [ overlay ] ; config = {}; }


{ pkgs ? import (fetchTarball https://git.io/Jf0cc) {} }:

# { sources ? import ./nix/sources.nix }:     # import the sources

# with
#   { overlay = _: pkgs:
#       { niv = (import sources.niv {}).niv;    # use the sources :)
#       };
#   };
# import sources.nixpkgs                  # and use them again!
#   { overlays = [ overlay ] ; config = {}; }


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
      grpclib
      setuptools
      Flask    
      Pillow
      python-lsp-server
      rope
      mypy-ls
      pyls-isort
      python-lsp-black
      black
      autoflake
      pyflakes 
      numpy
      scipy
      pandas
      matplotlib
      pytest
      pylint
'';
  };
in

pkgs.mkShell {
  buildInputs = [ 
    customPython 
  ];
}

# let
#   sources = import ./prjSource/nix/sources.nix;
#   pkgs = import sources.nixpkgs { };
#   inherit (pkgs.lib) optional optionals;
#   mach-nix = import (builtins.fetchGit {
#     url = "https://github.com/DavHau/mach-nix/";
#     ref = "refs/tags/3.1.1";
#   }) {
#     pkgs = pkgs;

#     # optionally specify the python version
#     # python = "python38";

#     # optionally update pypi data revision from https://github.com/DavHau/pypi-deps-db
#     # pypiDataRev = "some_revision";
#     # pypiDataSha256 = "some_sha256";
#   };
#   customPython = mach-nix.mkPython {
#     requirements = ''
#       copier
#       pytest
#       f90wrap
#     '';
#     providers = {
#       _default = "nixpkgs,wheel,sdist";
#       pytest = "nixpkgs";
#     };
#     overrides_pre = [
#       (pythonSelf: pythonSuper: {
#         pytest = pythonSuper.pytest.overrideAttrs (oldAttrs: {
#           doCheck = false;
#           doInstallCheck = false;
#         });
#         f90wrap = pythonSelf.buildPythonPackage rec {
#           pname = "f90wrap";
#           version = "0.2.3";
#           src = pkgs.fetchFromGitHub {
#             owner = "jameskermode";
#             repo = "f90wrap";
#             rev = "master";
#             sha256 = "0d06nal4xzg8vv6sjdbmg2n88a8h8df5ajam72445mhzk08yin23";
#           };
#           buildInputs = with pkgs; [ gfortran stdenv ];
#           propagatedBuildInputs = with pythonSelf; [
#             setuptools
#             setuptools-git
#             wheel
#             numpy
#           ];
#           preConfigure = ''
#             export F90=${pkgs.gfortran}/bin/gfortran
#           '';
#           doCheck = false;
#           doIstallCheck = false;
#         };
#       })
#     ];
#     pkgs = pkgs;
#   };
# in pkgs.mkShell { buildInputs = with pkgs; [ customPython ]; }
