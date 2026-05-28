{
  inputs = {
    gen.url = "github:sini/gen";
    genx.url = "github:sini/genx";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };

  outputs =
    inputs@{ gen, nixpkgs, ... }:
    let
      genxLib = inputs.genx.lib;
    in
    gen.lib.mkCi {
      inherit inputs;
      name = "genx";
      testModules = ./tests;
      specialArgs = { inherit genxLib; };
    };
}
