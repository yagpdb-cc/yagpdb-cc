---
title: Coin Flip
---

This command flips a coin landing on heads or tails to lose or double the bet.

:::caution

This command assumes that you have an existing currency system set up.

:::

## Trigger

**Type:** `Command`<br />
**Trigger:** `coinflip`

## Usage

- `-coinflip <heads/tails> <bet>` - Flips the coin, betting `bet` on the result being `heads`/`tails`.

## Configuration

- 📌 `$CHANNEL`<br />
  Channel ID where the game is played. Set to `.Channel.ID` to allow play in any channel.

- `$MIN_BET`<br />
  Minimum amount users can bet.

- `$MAX_BET`<br />
  Maximum amount users can bet.

- 📌 `$DB_KEY`<br />
  Database entry name where the currency is stored.

- `$COOLDOWN`<br />
  Cooldown for the command in seconds.

## Code

```gotmpl file=../../../src/fun/coinflip.go.tmpl

```

## Author

This custom command was written by [@DaviiD1337](https://github.com/DaviiD1337) with contributions from [@H1nr1](https://github.com/H1nr1).
