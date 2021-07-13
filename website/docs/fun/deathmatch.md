---
title: Deathmatch Game
---

This command is a replica of the deathmatch command from Yggdrasil.

## Trigger

**Type:** `Command`<br />
**Trigger:** `deathmatch`

## Usage

- `-deathmatch` - Play against the default opponent (YAGPDB, unless you changed it in the options).
- `-deathmatch <user>` - Play against the user provided.
- `-deathmatch <user0> <user1>` - Make the first user play against the second user.

:::note Restrictions

To prevent this command from overloading YAGPDB, no more than 5 deathmatch games can be played in a server at any time.

:::

## Configuration

- `$Emojis`<br />
  A pair of emojis to use for the deathmatch messages. The default values will work fine if you aren't selfhosting.

- `$YAG`<br />
  The default opponent.

- 📌 `$Channels`<br />
  A list of channel IDs to use when executing the command loop, to reduce lag. These can be any channels in your server.

## Code

```gotmpl file=../../../src/fun/deathmatch.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
