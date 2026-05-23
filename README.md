# genx — Extended Nix Primitives

Zero-dependency utility library for Nix. All functions use only `builtins` — no nixpkgs `lib` required.

Includes a complete, spec-compliant [xxHash64](https://github.com/Cyan4973/xxHash) implementation in pure Nix.

## Modules

### xxh64

Pure-Nix xxHash64 — all 21 test vectors match the official `xxhsum` reference.

```nix
genx.xxh64 "hello"            # → "26c7827d889f6da3"
genx.xxh64WithSeed 42 "abc"   # → "13c1d910702770e6"
```

Implementation highlights: split `{hi, lo}` representation, constant-specialized prime multiplies, precomputed rotations, `deepSeq` at fold boundaries (Haskell `BangPatterns` pattern). See `lib/xxh64.nix` for details.

### Low-level primitives

| Module | Provides |
|---|---|
| `bits` | `bitShiftLeft`, `bitShiftRight` for signed 64-bit integers |
| `wrapping` | 64-bit modular `wrapAdd`, `wrapSub`, `wrapMul`, `wrapNeg`, `rotl64` |
| `split` | `{hi, lo}` split arithmetic optimized for xxh64 |
| `bytes` | `stringToBytes`, `readLE64`/`readLE32`, byte lookup table via `builtins.fromJSON` |
| `radix` | `intToHex`, `intToHexPadded` |
| `math` | `pow`, `powi`, `abs`, `mod`, `mantissa`, `round` |

### Higher-level utilities

| Module | Provides |
|---|---|
| `lists` | `indexOf`, `sublist`, `split`, `lsplit`, `rsplit`, `lpad`, `rpad`, `reverse`, `replicate`, `range`, `imap0`, `last`, `indicesOf`, `removeElems` |
| `strings` | `charAt`, `indexOfChar`, `lastIndexOfChar`, `removeChars`, `lpadString`, `rpadString`, `toChars` |
| `encoding` | `encodeBinary`, `decodeBinary`, `encodeBinaryBytes` (MSB-first bit lists) |
| `trivial` | `not`, `nand`, `nor`, `xor`, `xnor`, `imply`, `implyDefault`, `applyArgs`, `applyAutoArgs` |

## Usage

### As a flake input

```nix
{
  inputs.genx.url = "github:sini/genx";

  outputs = { genx, ... }:
    let
      gx = genx.lib;
    in {
      hash = gx.xxh64 "hello";                              # → "26c7827d889f6da3"
      shifted = gx.bits.bitShiftLeft 8 1;                   # → 256
      product = gx.wrapping.wrapMul a b;                    # → (a * b) mod 2^64
      bytes = gx.bytes.stringToBytes "AB";                  # → [ 65 66 ]
      reversed = gx.lists.reverse [ 1 2 3 ];                # → [ 3 2 1 ]
      trimmed = gx.strings.removeChars "aeiou" "hello";     # → "hll"
    };
}
```

### Without flakes

```nix
let genx = import ./path/to/genx/lib;
in genx.xxh64 "hello"  # → "26c7827d889f6da3"
```

## Testing

```bash
cd templates/ci
nix flake check --override-input genx ../..
```

## Architecture

```
genx/
  default.nix          — entry point
  flake.nix            — flake outputs
  lib/
    default.nix        — re-exports all modules + xxh64
    xxh64.nix          — pure-Nix xxHash64 implementation
    bits.nix           — bitShiftLeft, bitShiftRight (signed 64-bit)
    wrapping.nix       — 64-bit modular arithmetic
    split.nix          — {hi,lo} split arithmetic (xxh64-optimized)
    bytes.nix          — stringToBytes, readLE64/32, byte table
    radix.nix          — intToHex, intToHexPadded
    math.nix           — pow, abs, mod, round
    encoding.nix       — binary encode/decode
    lists.nix          — indexOf, sublist, split, lpad, rpad, reverse
    strings.nix        — charAt, indexOfChar, removeChars, pad
    trivial.nix        — boolean ops, imply, applyAutoArgs
  bench/               — xxh64 vs SHA256 benchmark suite
  templates/ci/        — test suite
```

## Related

- [gen](https://github.com/sini/gen) — foundational Nix primitives (search monad, identity hashing, validation)

## License

MIT — see [LICENSE](LICENSE)
