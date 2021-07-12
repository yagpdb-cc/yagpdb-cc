---
title: Coin Flip
---

This command is a game of heads or tails which users can play.

## Trigger

**Type:** `Command`<br />
**Trigger:** `coinflip`

## Usage

- `-coinflip <heads/tails> <bet>` - Flips the coin, betting `bet` on the result being `heads`/`tails`.

## Configuration

- 📌 `$c`<br />
  Channel ID where the game is played.

- `$minbet`<br />
  Minimum amount people can bet.

- `$maxbet`<br />
  Maximum amount people can bet.

- 📌 `$db`<br />
  Database entry name where the credits are stored.

- `$cooldown`<br />
  Cooldown for the command in seconds.

## Code

```go file=../../../src/fun/coinflip.go.tmpl

```

## Author

This custom command was written by [@DaviiD1337](https://github.com/DaviiD1337).
