---
title: View Avatar
---

This command views the avatar of a user, defaulting to the triggering user.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(avatar|av|pfp)(\s+|\z)`

## Usage

- `-avatar` - Views your own avatar.
- `-avatar <user>` - Views the avatar of the user provided.

:::tip Aliases

Instead of `avatar`, you can also use `av` or `pfp`.

:::

## Code

```go file=../../../src/info/avatar.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
