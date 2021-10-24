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
In `$exceptions` dict you need to fill with a character and the threshold of each one.

Like this:

```
{{ $exceptions := dict
"o" 3
"p" 2
}}
```

This will leave the "o" three times and the "p" two times.

:::caution

Adding too much exceptions can cause the command to need a lot of time at execution.

:::

Then in `$defaultThreshold` you can define the threshold for characters that have not exeptions.

## Examples

```
{{ $toFix := "ooooooooooopppppppppppssssssss" }}
{{ $exceptions := dict
"o" 3
"p" 2
}}
{{ $defaultThreshold := 1 }}
```
will output `"ooopps"`.
```
{{ $toFix := "heeeeeellllllllllloooooooooo" }}
{{ $exceptions := dict
"l" 2
}}
{{ $defaultThreshold := 1 }}
```
will output `"hello"`.

```
{{ $toFix := "heeeeeellllllllllloooooooooo" }}
{{ $exceptions := dict
"l" 3
}}
{{ $defaultThreshold := 2 }}
```
will output `"heellloo"`.

## Author

Written by [Faculord](https://github.com/LattandiFacundo).
