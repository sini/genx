{ genxLib, ... }:
let
  inherit (genxLib.radix) intToHex intToHexPadded;
in
{
  flake.tests.primitives-radix.test-zero = {
    expr = intToHex 0;
    expected = "0";
  };
  flake.tests.primitives-radix.test-255 = {
    expr = intToHex 255;
    expected = "ff";
  };
  flake.tests.primitives-radix.test-256 = {
    expr = intToHex 256;
    expected = "100";
  };
  flake.tests.primitives-radix.test-padded = {
    expr = intToHexPadded 16 255;
    expected = "00000000000000ff";
  };
  flake.tests.primitives-radix.test-padded-zero = {
    expr = intToHexPadded 4 0;
    expected = "0000";
  };
  flake.tests.primitives-radix.test-single-digit = {
    expr = intToHex 15;
    expected = "f";
  };
  flake.tests.primitives-radix.test-one = {
    expr = intToHex 1;
    expected = "1";
  };
  flake.tests.primitives-radix.test-large = {
    expr = intToHex 65535;
    expected = "ffff";
  };
  flake.tests.primitives-radix.test-padded-no-truncate = {
    expr = intToHexPadded 1 255;
    expected = "ff";
  };
}
