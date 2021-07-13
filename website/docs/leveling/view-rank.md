---
title: View Rank
---

This command displays the rank of a member, defaulting to the triggering member.
There are also overloads to set your rank card background (if enabled) and rank embed colour.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(rank|lvl|xp)(\s+|\z)`

## Usage

- `-rank` - Views your own rank.
- `-rank <user>` - Views the rank of the user provided.
- `-rank set-color <hex>` - Sets your rank embed colour to the hex provided.
- `-rank set-color default` - Sets your rank embed colour to the default value.
- `-rank set-background <link>` - Sets your rank card background.
- `-rank set-background del` - Deletes your rank card background.

## Configuration

- `$rankcard`<br />
  Whether or not a rank card should be displayed instead of an embed.

- `$background`<br />
  The default rank card background. Only applies if `$rankcard` is `true`.

## Code

```gotmpl file=../../../src/leveling/rank.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
