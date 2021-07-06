---
sidebar_position: 7
title: Display Struct
---

This command shows you all the available properties of a structure in addition to a link to the Discord docs on that structure.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(struct)(ure)?(\s+|\z)`

## Usage

- `-struct <name>` - Displays the structure with the name provided. `<name>` must be one of `channel`, `guild`, `user`, `member`, or `message`.

:::tip Aliases

Instead of `struct`, you can also use `structure`.

:::

## Code

```go file=../../../src/utilities/struct.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
