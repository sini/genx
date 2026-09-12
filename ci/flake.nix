{
  inputs = {
    gen-harness.url = "github:sini/gen-harness";
    genx.url = "github:sini/genx";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };

  outputs =
    inputs@{ gen-harness, nixpkgs, ... }:
    let
      genxLib = inputs.genx.lib;
    in
    gen-harness.lib.mkCi {
      inherit inputs;
      name = "genx";
      testModules = ./tests;
      specialArgs = { inherit genxLib; };
    };
}
