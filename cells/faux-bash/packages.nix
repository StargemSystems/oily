{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  faux-bash = nixpkgs.stdenv.mkDerivation {
    pname = "faux-bash";
    version = "0.1.0";
    src = ./script.sh;
    dontUnpack = true;
    dontStrip = true;
    passthru.shellPath = cell.packages.faux-bash + "/bin/bash";
    buildInputs = with nixpkgs; [ 
      inputs.cells.oil-shell.packages.oil
      bash
      shc 
    ];
    buildPhase = ''
      substitute $src faux.sh \
        --subst-var-by bash ${nixpkgs.bash} \
        --subst-var-by oil ${inputs.cells.oil-shell.packages.oil}
      shc -f faux.sh -o faux
    '';
    installPhase = ''
      mkdir -p $out/bin
      mv faux $out/bin/faux-bash
      chmod +x $out/bin/faux-bash
      ln -rs $out/bin/faux-bash $out/bin/bash
    '';
  };
}
