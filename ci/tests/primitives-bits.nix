{ genxLib, ... }:
let
  inherit (genxLib.bits) bitShiftLeft bitShiftRight;
  inherit (genxLib.math) pow mod;
  shl = bitShiftLeft;
  shr = bitShiftRight;
  intMin = -9223372036854775807 - 1;
in
{
  flake.tests.primitives-bits.test-shl-zero-shift = {
    expr = shl 0 42;
    expected = 42;
  };
  flake.tests.primitives-bits.test-shl-one = {
    expr = shl 1 1;
    expected = 2;
  };
  flake.tests.primitives-bits.test-shl-sign-bit = {
    expr = shl 63 1;
    expected = intMin;
  };
  flake.tests.primitives-bits.test-shl-64-is-zero = {
    expr = shl 64 255;
    expected = 0;
  };
  flake.tests.primitives-bits.test-shr-zero-shift = {
    expr = shr 0 42;
    expected = 42;
  };
  flake.tests.primitives-bits.test-shr-basic = {
    expr = shr 1 8;
    expected = 4;
  };
  flake.tests.primitives-bits.test-shr-sign-bit = {
    expr = shr 1 (-1);
    expected = 9223372036854775807;
  };
  flake.tests.primitives-bits.test-shr-64-is-zero = {
    expr = shr 64 255;
    expected = 0;
  };
  flake.tests.primitives-bits.test-negative-shift-reverses = {
    expr = shl (-3) 16;
    expected = shr 3 16;
  };
  flake.tests.primitives-bits.test-shl-62-3 = {
    # 3 << 62 = 0xC000000000000000 = -4611686018427387904 signed
    expr = shl 62 3;
    expected = (-4611686018427387904);
  };
  flake.tests.primitives-bits.test-shl-62-2 = {
    # 2 << 62 = 0x8000000000000000 = intMin
    expr = shl 62 2;
    expected = (-9223372036854775807 - 1);
  };
  flake.tests.primitives-bits.test-pow-basic = {
    expr = pow 2 10;
    expected = 1024;
  };
  flake.tests.primitives-bits.test-pow-zero = {
    expr = pow 5 0;
    expected = 1;
  };
  flake.tests.primitives-bits.test-mod-basic = {
    expr = mod 7 3;
    expected = 1;
  };

  # bitShiftRight edge cases
  flake.tests.primitives-bits.test-shr-63-negative = {
    expr = shr 63 (-1);
    expected = 1;
  };
  flake.tests.primitives-bits.test-shr-63-positive = {
    expr = shr 63 42;
    expected = 0;
  };
  flake.tests.primitives-bits.test-shr-multi-negative = {
    expr = shr 2 (-4);
    # -4 unsigned = 0xFFFFFFFFFFFFFFFC, >> 2 = 0x3FFFFFFFFFFFFFFF = 4611686018427387903
    expected = 4611686018427387903;
  };

  # Math function tests
  flake.tests.primitives-bits.test-abs-positive = {
    expr = (genxLib.math).abs 42;
    expected = 42;
  };
  flake.tests.primitives-bits.test-abs-negative = {
    expr = (genxLib.math).abs (-7);
    expected = 7;
  };
  flake.tests.primitives-bits.test-abs-zero = {
    expr = (genxLib.math).abs 0;
    expected = 0;
  };
  # shift=63 even value (tests the else-0 path)
  flake.tests.primitives-bits.test-shl-63-even = {
    expr = shl 63 2;
    expected = 0;
  };
  # small shift, no negate path
  flake.tests.primitives-bits.test-shl-10 = {
    expr = shl 10 1;
    expected = 1024;
  };
  # negative shift on bitShiftRight
  flake.tests.primitives-bits.test-shr-negative-shift = {
    expr = shr (-2) 8;
    expected = shl 2 8;
  };
}
