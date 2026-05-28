{ genxLib, ... }:
let
  inherit (genxLib.strings)
    charAt
    indexOfChar
    lastIndexOfChar
    removeChars
    lpadString
    rpadString
    toChars
    ;
in
{
  flake.tests.primitives-strings.test-char-at = {
    expr = charAt 0 "hello";
    expected = "h";
  };
  flake.tests.primitives-strings.test-char-at-oob = {
    expr = charAt 10 "hi";
    expected = null;
  };
  flake.tests.primitives-strings.test-index-of-char = {
    expr = indexOfChar "l" "hello";
    expected = 2;
  };
  flake.tests.primitives-strings.test-remove-chars = {
    expr = removeChars "aeiou" "hello";
    expected = "hll";
  };
  flake.tests.primitives-strings.test-lpad-string = {
    expr = lpadString "0" 5 "hi";
    expected = "000hi";
  };
  flake.tests.primitives-strings.test-rpad-string = {
    expr = rpadString "." 5 "hi";
    expected = "hi...";
  };
  flake.tests.primitives-strings.test-to-chars = {
    expr = toChars "abc";
    expected = [
      "a"
      "b"
      "c"
    ];
  };
  flake.tests.primitives-strings.test-last-index-of-char = {
    expr = lastIndexOfChar "l" "hello";
    expected = 3;
  };
  flake.tests.primitives-strings.test-last-index-of-char-none = {
    expr = lastIndexOfChar "z" "hello";
    expected = null;
  };
  flake.tests.primitives-strings.test-char-at-negative = {
    expr = charAt (-1) "hello";
    expected = null;
  };
  flake.tests.primitives-strings.test-index-of-char-not-found = {
    expr = indexOfChar "z" "hello";
    expected = null;
  };
  flake.tests.primitives-strings.test-to-chars-empty = {
    expr = toChars "";
    expected = [ ];
  };
  flake.tests.primitives-strings.test-remove-chars-list = {
    expr = removeChars [ "a" "e" ] "abcde";
    expected = "bcd";
  };
  flake.tests.primitives-strings.test-lpad-string-noop = {
    expr = lpadString "0" 2 "hello";
    expected = "hello";
  };
  flake.tests.primitives-strings.test-rpad-string-noop = {
    expr = rpadString "." 2 "hello";
    expected = "hello";
  };
}
