---
title: Fun Info
---

This command shows statistics connected to a user for the [counting](counting), [qotd](qotd) and [x-word-story](x-word-story) systems.

## Trigger

**Type:** `Command`<br />
**Trigger:** `funinfo`

## Usage

- `-funinfo` - Shows statistics for the triggering user.
- `-funinfo <user>` - Shows statistics for the user provided.

## Configuration

- `$cooldown`<br />
  Command cooldown in seconds. Set to 0 to disable cooldown.

- `$colour`<br />
  Colour of the embed, as a decimal.

:::tip

To use hex for the colour, simply append a `0x` in front, e.g. `0xFF0FF`.

:::

## Code

```go file=../../../src/fun/funinfo.go.tmpl

```

## Author

This custom command was written by [@SpecialEliteSNP](https://github.com/SpecialEliteSNP).
