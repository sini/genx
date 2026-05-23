{
  inputs = {
    genx.url = "github:sini/genx";
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
  };

  outputs =
    {
      genx,
      nixpkgs,
      ...
    }:
    let
      lib = nixpkgs.lib;
      genxLib = genx.lib;
      forAllSystems = lib.genAttrs lib.systems.flakeExposed;
      testFiles = lib.pipe (builtins.readDir ./tests) [
        (lib.filterAttrs (n: v: v == "regular" && lib.hasSuffix ".nix" n))
        builtins.attrNames
      ];
      tests = lib.foldl' (
        acc: file: acc // (import ./tests/${file} { inherit genxLib; })
      ) { } testFiles;
    in
    {
      inherit tests;
      checks = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          assertTests =
            lib.mapAttrsToList (
              suite: subtests:
              lib.mapAttrsToList (
                name: t:
                if t.expr == t.expected then
                  true
                else
                  throw "FAIL ${suite}.${name}: got ${builtins.toJSON t.expr}, expected ${builtins.toJSON t.expected}"
              ) subtests
            ) tests;
        in
        {
          default = pkgs.runCommand "genx-tests" { } ''
            echo "${builtins.toJSON (builtins.length (lib.flatten assertTests))} tests passed"
            touch $out
          '';
        }
      );
    };
}
