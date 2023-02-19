{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  default = cell.packages.faux-bash;
  faux-bash = nixpkgs.mkDerivation {
    name = "faux-bash";
    version = "0.1.0";
    src = ./script.sh;
    passthru.shell = cell.packages.faux-bash + "/bin/bash";
    buildInputs = with nixpkgs; [
      inputs.cells.oil-shell.packages.oil
      bash
      shc
    ];
    buildPhase = ''
      substituteAll $src faux.sh
      shc -f faux.sh -o faux
    '';
    installPhase = ''
      mkdir -p $out/bin
      mv faux $out/bin/bash
      chmod +x $out/bin/bash
    '';
  };
}
