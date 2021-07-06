---
sidebar_position: 3
title: View Channel Info
---

This command views information about channels, defaulting to the current channel.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(channel)(-?info)?(\s+|\z)`

## Usage

- `-channel` - Views information about the current channel.
- `-channel <channel>` - Views information about the channel provided.

:::tip Aliases

Instead of `channel`, you can also use `channelinfo`.

:::

## Code

```go file=../../../src/info/channel.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
