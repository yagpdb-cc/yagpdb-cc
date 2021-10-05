---
title: Remove repeated characters
---

Removes repeated characters in strings.
Useful addition to commands that needs to compare words.

## Code

```gotmpl file=../../../src/code_snippets/remove_repeated_characters.go.tmpl

```

## Usage

Replace `$toFix` with the string you need to remove the repeated characters.
and `$exception` with a letter you want to keep two.

## Example

- `$toFix = "ooooooooooopppppppppppssssssss"`,
`$exception = "o"` and `$threshold = 3` will output "ooops".
- `$toFix = "heeeeelllllooooooo"`, `$exception = "l"` and `$threshold = 2` will output "hello".

## Author

Written by [Faculord](https://github.com/LattandiFacundo).
