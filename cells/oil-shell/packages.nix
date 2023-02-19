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
      version = "0.14.1";
      src = fetchurl {
        url = "https://www.oilshell.org/download/oil-${version}.tar.xz";
        hash = "sha256-RB7cye/jVtGQY4f6VlX7VNfrCJcCoynK9rRckiYjMEk=";
      };
    });
}
