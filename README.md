# genx — Extended Nix Primitives

Zero-dependency utility library for Nix. All functions use only `builtins` — no nixpkgs `lib` required.

## Modules

| Module | Provides |
|---|---|
| `lists` | `indexOf`, `sublist`, `split`, `lsplit`, `rsplit`, `lpad`, `rpad`, `reverse`, `replicate`, `range`, `imap0`, `last`, `indicesOf`, `removeElems` |
| `strings` | `charAt`, `indexOfChar`, `lastIndexOfChar`, `removeChars`, `lpadString`, `rpadString`, `toChars` |
| `math` | `pow`, `powi`, `abs`, `mod`, `mantissa`, `round` |
| `encoding` | `encodeBinary`, `decodeBinary`, `encodeBinaryBytes` (MSB-first bit lists) |
| `trivial` | `not`, `nand`, `nor`, `xor`, `xnor`, `imply`, `implyDefault`, `applyArgs`, `applyAutoArgs` |

## Usage

### As a flake input

```nix
{
  inputs.genx.url = "github:sini/genx";

  outputs = { genx, ... }:
    let
      gx = genx { };
    in {
      example = gx.lists.indexOf 3 [ 1 2 3 4 ];  # → 2
    };
}
```

### Without flakes

```nix
let
  genx = import ./path/to/genx { };
in {
  reversed = genx.lists.reverse [ 1 2 3 ];              # → [ 3 2 1 ]
  bits = genx.encoding.encodeBinary 42;                   # → [ 1 0 1 0 1 0 ]
  trimmed = genx.strings.removeChars "aeiou" "hello";     # → "hll"
  result = genx.trivial.imply null 42;                     # → null (falsy → default)
}
```

## Testing

```bash
cd templates/ci
nix flake check --override-input genx ../..
```

## Related

- [gen](https://github.com/sini/gen) — foundational Nix primitives (search monad, identity hashing, xxh64 reference implementation, bit manipulation, wrapping arithmetic)

## License

MIT — see [LICENSE](LICENSE)
