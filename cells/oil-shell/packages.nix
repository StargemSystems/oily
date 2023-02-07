{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  default = cell.packages.oil;
  oil = with nixpkgs;
    oil.overrideAttrs (old: rec {
      configureFlags = ["--readline=${readline}" "--datarootdir=$out"];
      version = "0.14.0";
      src = fetchurl {
        url = "https://www.oilshell.org/download/oil-${version}.tar.xz";
        hash = "sha256-ZrT2vHfbc0S9Q9e9lDiyptfSC3CIiQs8Co9FODil7oY=";
      };
    });
}
