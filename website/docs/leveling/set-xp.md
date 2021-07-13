---
title: Set XP/Level
---

This command allows administrators to set the experience or level of a user.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(set-?(xp|level))(\s+|\z)`

:::caution

Unless you would like everyone to be able to set experience/level, we advise that you restrict this command to a staff role in the role restrictions.

:::

## Usage

- `-setxp <user> <xp>` - Sets the experience of the user provided.
- `-setlevel <user> <level>` - Sets the level of the user provided.

:::info Aliases

Instead of using `setxp`, you can also use `set-xp`. Similarly, in place of `setlevel`, you can also use `set-level`.

:::

## Code

```gotmpl file=../../../src/leveling/set_xp.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
