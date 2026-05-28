{ genxLib, ... }:
let
  inherit (genxLib) xxh64 xxh64WithSeed;
in
{
  flake.tests.xxh64.test-empty = {
    expr = xxh64 "";
    expected = "ef46db3751d8e999";
  };
  flake.tests.xxh64.test-single-char = {
    expr = xxh64 "a";
    expected = "d24ec4f1a98c6e5b";
  };
  flake.tests.xxh64.test-abc = {
    expr = xxh64 "abc";
    expected = "44bc2cf5ad770999";
  };
  flake.tests.xxh64.test-hello-world = {
    expr = xxh64 "Hello, World!";
    expected = "c49aacf8080fe47f";
  };
  flake.tests.xxh64.test-31-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz01234";
    expected = "16058c7b947da137";
  };
  flake.tests.xxh64.test-32-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz012345";
    expected = "bf2cd639b4143b80";
  };
  flake.tests.xxh64.test-33-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz0123456";
    expected = "4f89e4082bcbf673";
  };
  flake.tests.xxh64.test-64-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZxy";
    expected = "8c29ab81803fa6d0";
  };
  flake.tests.xxh64.test-json-identity = {
    expr = xxh64 "{\"hostname\":\"igloo\",\"user\":\"tux\"}";
    expected = "6df43dd6492300df";
  };
  flake.tests.xxh64.test-256-zeros = {
    expr = xxh64 (builtins.concatStringsSep "" (builtins.genList (_: "0") 256));
    expected = "43f6c51af9f03845";
  };
  flake.tests.xxh64.test-output-length = {
    expr = builtins.stringLength (xxh64 "test");
    expected = 16;
  };
  flake.tests.xxh64.test-seeded = {
    expr = xxh64WithSeed 42 "abc";
    expected = "13c1d910702770e6";
  };
  flake.tests.xxh64.test-4-bytes = {
    expr = xxh64 "abcd";
    expected = "de0327b0d25d92cc";
  };
  flake.tests.xxh64.test-7-bytes = {
    expr = xxh64 "abcdefg";
    expected = "1860940e2902822d";
  };
  flake.tests.xxh64.test-8-bytes = {
    expr = xxh64 "abcdefgh";
    expected = "3ad351775b4634b7";
  };
  flake.tests.xxh64.test-15-bytes = {
    expr = xxh64 "abcdefghijklmno";
    expected = "2e1218a2b1375068";
  };
  flake.tests.xxh64.test-36-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz0123456789";
    expected = "64f23ecf1609b766";
  };
  flake.tests.xxh64.test-40-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz01234567890123";
    expected = "0c5f86f4cfd55a9e";
  };
  flake.tests.xxh64.test-48-bytes = {
    expr = xxh64 "abcdefghijklmnopqrstuvwxyz0123456789012345678901";
    expected = "9910839e52da6706";
  };
  flake.tests.xxh64.test-seeded-zero-matches-default = {
    expr = xxh64WithSeed 0 "abc" == xxh64 "abc";
    expected = true;
  };
  flake.tests.xxh64.test-seeded-negative = {
    expr = xxh64WithSeed (-1) "abc";
    expected = "28306e589cc02176";
  };
}
