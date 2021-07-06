---
sidebar_position: 2
title: Start Game
---

This command starts the connect-four game.

For more information about the connect-four game, see [this](overview) page.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(?:\-|<@!?204255221017214977>)\s*(?:c(?:on(?:nect)?)?4)(?: +|\z)`

:::note Custom prefixes

By default, this regex uses the `-` prefix for commands. If you have a different prefix, change the `-` to your own prefix.
For example, if you wanted to use `!` as the prefix, you would use:

`\A(?:\!|<@!?204255221017214977>)\s*(?:c(?:on(?:nect)?)?4)(?: +|\z)`

:::

## Usage

- `-connect4 <user>` - Starts a connect-four game with the given user.
- `-connect4` - Starts a connect-four game against yourself.

:::note Aliases

Instead of using `-connect4`, you can also use `-con4` or `-c4`.

:::

## Code

```go file=../../../../src/fun/connect4_system/start_game.go.tmpl

```

## Author

This custom command was written by [zen | ゼン](https://github.com/z3nn13).
