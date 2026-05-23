{
  description = "genx: extended Nix primitives — lists, strings, encoding, trivial";
  outputs = _: {
    __functor = _: import ./.;
    lib = import ./lib;
  };
}
