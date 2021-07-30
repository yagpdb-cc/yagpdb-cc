---
title: Parse Text
---

Code snippet to parse text into a slice of arguments, much like how `.CmdArgs` is constructed.

Licensed under the terms of the Unlicense.

## Code

```gotmpl file=../../../src/code_snippets/parse_text.go.tmpl

```

## Usage

First, add in the code snippet above:

```gotmpl
{{/* code snippet goes here */}}
```

Next, change the value of `$text` to the value you like. Say we wanted to use `.Message.Content` rather than `.StrippedMsg`:

```diff {3}
{{/* Let $text be the text. */}}
- {{ $text := .StrippedMsg }}
+ {{ $text := .Message.Content }}
{{/* rest of code snippet goes here */}}
```

You may now access the parsed slice of arguments using `$clean`, which will be a `cslice`.

```gotmpl {2}
{{/* code snippet goes here */}}
Parsed args: `{{json $clean}}`
```

:::tip

You can convert `$clean` to a string slice (what `.CmdArgs`, `.Args`, and so on are) by using the `StringSlice` method: `{{$clean.StringSlice}}`.

:::

## Author

This code snippet was written by [@jo3-l](https://github.com/jo3-l).
