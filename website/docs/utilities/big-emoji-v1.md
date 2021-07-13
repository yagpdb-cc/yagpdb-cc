---
title: Big Emoji v1
---

This command enlarges emojis.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(be|big-?emo(te|ji))(\s+|\z)(\s+|\z)`

## Usage

- `-bigemoji <emoji>` - Enlarges the emoji provided. Can be either a Discord default emoji or a custom emoji.

:::tip Aliases

Instead of `bigemoji`, you can also use `be`, `bigemote`, `big-emote`, and `big-emoji`.

:::

## Code

```gotmpl file=../../../src/utilities/big_emoji.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l) and [@Satty9361](https://github.com/Satty9361).
