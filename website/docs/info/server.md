---
title: View Server Info
---

This command views information about the server. It also includes a subcommand that allows you to view the server icon.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(server|guild)(-?info)?(\s+|\z)`

## Usage

- `-serverinfo` - Views information about the server.
- `server icon` - Views the server icon.

:::tip Aliases

Instead of `serverinfo`, you can also use `server`, `guild`, `guildinfo`, `serverinfo`, `guild-info`, or `server-info`.

:::

## Code

```go file=../../../src/info/server.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
