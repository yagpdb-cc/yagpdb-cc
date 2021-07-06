---
sidebar_position: 20
title: Text to Emoji Convertor
---

This command converts text provided to emoji.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(?:\-|<@!?204255221017214977>)\s*(?:tte|emojify|emotify)(?: +|\z)`

## Usage

- `-tte <text>` - Converts `text` to emoji. In addition to alphanumeric characters, the following special characters are supported: `#`, `*`, `!`, and `?`.

:::tip Aliases

Instead of `tte`, you can also use `emojify` or `emotify`.

:::

## Code

```go file=../../../src/fun/tte.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
