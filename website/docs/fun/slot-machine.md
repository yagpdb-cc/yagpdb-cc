---
title: Slot Machine
---

This command runs the slot machine game.

:::caution

This command assumes that you have an existing currency system set up to provide credits to users.

:::

## Trigger

**Type:** `Command`<br />
**Trigger:** `slotmachine`

## Usage

- `slotmachine <amount>` - Runs the slot machine, betting `amount` credits.

## Configuration

- 📌 `$dbName`<br />
  Database entry name that stores the user's credits.

- `$gameName`<br />
  What the game should be called.

- `$user`<br />
  What the player should be called.

- `$spinName`<br />
  What to show to users when the slot machine is currently spinning.

- `$lose`<br />
  Text to show users when they lose.

- `$win`<br />
  Text to show users when they win.

- `$profit`<br />
  What 'profit' should be called.

- `$currency`<br />
  Name of the currency.

- `$payOut`<br />
  What 'pay out' should be called.

- `$youHave`<br />
  What 'you have' should be called.

- `$helper`<br />
  Helper text title.

- `$helpText`<br />
  Help text for the command.

- `$notEnough`<br />
  Message to show to users when they do not have sufficient credits.

- `$betBelow1`<br />
  Message to show to users when they bet less than one credit.

- 📌 `$bettingChannel`<br />
  Channel ID where users can play the game.

- `$minMax`<br />
  Whether there should be a minimum/maximum amount users can bet (see the options below).

- `$minBet`<br />
  Minimum amount people can bet.

- `$maxBet`<br />
  Maximum amount people can bet.

- `$outOfRange`<br />
  Message to show to users when they bet an amount that is less than the minimum / greater than the maximum.

- 📌 `$channels`<br />
  A list of arbitrary channel IDs in your server to prevent the game from lagging.

## Code

```gotmpl file=../../../src/fun/slot_machine.go.tmpl

```

## Author

This custom command was written by [@Pedro-Pessoa](https://github.com/Pedro-Pessoa).
