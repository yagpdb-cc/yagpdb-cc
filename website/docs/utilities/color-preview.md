---
sidebar_position: 6
title: Preview Color
---

This command allows you to preview how colours look. Also includes some information about the colour, such as its hexadecimal/decimal equivalent.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(preview|color)(\s+|\z)`

## Usage

- `-preview <hex>` - Previews the color with the hex provided.
- `-preview <dec> -dec` - Previews the color with the decimal value provided.

:::note

The reason we have `-dec` is to distinguish hex from decimal in ambiguous cases. For example, `111111` is both a valid hex and decimal color.

:::

:::tip Aliases

Instead of `preview`, you can also use `color`.

:::

## Code

```go file=../../../src/utilities/preview.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
