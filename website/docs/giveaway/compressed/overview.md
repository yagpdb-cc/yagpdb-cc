---
title: Overview
---

This is a highly compressed version of the giveaway system.

For more information about the giveaway packages in general, see [this](../overview) page.

## Features

- Start giveaways with duration, optional prize, number of participants, number of winners, and giveaway channel.
- End giveaways and announce winners instantly.
- Cancel giveaways without announcing winners.
- Re-roll an old giveaway to find new winners.
- List all active giveaways.
- `execCC` support for automating giveaway creation/cancellation/etc. from custom commands.

## Installation

This package contains two custom commands: the [main command](main-cc), and a [reaction handler](reaction-handler).

Both must be added for the system to work as expected. As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. Additionally, we've documented how and where to add these scripts down below.

### Main Command

Add the [main command](main-cc) as a new custom command.
The trigger is a command trigger type with value `giveaway`, but it will also work with a `StartsWith` or `Regex` trigger if set up properly.

:::caution

Unless you would like everyone to be able to manage giveaways, we advise that you restrict this command to a staff role in the role restrictions.

:::

Save for now, we'll come back to it later.

### Reaction Handler

Next, add the [reaction handler](reaction-handler) as a new custom command. The trigger is a reaction type with the `Added + Removed Reactions` option enabled.

:::info

At this point, your giveaway system should be usable! If you would like to customize the giveaway emoji, see [here](overview/#configuration).
For how to use it, please refer to the [usage](overview/#usage) section.

:::

## Configuration

There is one configurable value in this package, `$gEmoji`, which corresponds to the giveaway emoji that should be used.

:::danger

If you change the giveaway emoji to something different from the default, you need to change it in both the [main command](main-cc) and the [reaction handler](reaction-handler).
Otherwise, unexpected behavior may occur.

:::

## Usage

### `giveaway start <time> [prize]`

Starts a new giveaway.

#### Arguments

- `<time>` - Specifies the amount of time after which the giveaway winners will be announced/how long the giveaway will be active. Format is `(num)y(num)mo(num)w(num)d(num)h(num)m(num)s`.

  **Example:** `1y7mo2w1d3h4m15s = 1 year 7 months 2 weeks 1 day 3 hours 4 minutes and 15 seconds`.

  **Note:** Must not contain spaces in between. Stick to the format above only, i.e. use `d`, not `days` for specifying days and so on.

- `[prize]` - The prize of the giveaway, can be multiple words.

#### Optional Flags

| Flag |    Argument Type     |                                     Usage                                      |
| ---- | :------------------: | :----------------------------------------------------------------------------: |
| -p   |        number        |        specifies the max number of participants (default is unlimited).        |
| -w   |        number        |                specifies the number of winners (default is 1).                 |
| -c   | Channel (ID/Mention) | specifies the channel for giveaway to take place (default is current channel). |

#### Example

```
-giveaway start 1d12h Ps4 Pro -p 50 -w 2 -c #giveaways
```

Starts a giveaway in `#giveaways` which will remain active for 1 day 12 hours with the maximum participants set to 50 and number of winners set to 2.

### `giveaway end <id>`

Ends the giveaway with the ID provided and announces the winners instantly. Updates the giveaway announcement message.

:::info

The ID is the long number which can be obtained using the `giveaway list` command. It is also mentioned in the giveaway announcement embed.

:::

### `giveaway cancel <id>`

Cancels the giveaway with the ID provided without announcing the winners. Updates the giveaway announcement message.

### `giveaway reroll [id-or-n]`

Re-rolls an old giveaway, which was finished earlier, to find new winner(s). If no argument is passed, the most recently finished giveaway is re-rolled.

Accepts an optional argument which could either be the ID of an old giveway or a number between 1-10, which represents the *n*th previously finished giveaway.

#### Example

```
giveaway reroll 2
```

Re-rolls the giveaway finished before the most recently finished giveaway.

### `giveaway list`

Lists all active giveaways with their IDs, prize, and ending time.

## execCC support

This command package has intuitive support for `execCC`. Simply call the command with data set to a string structured like follows:

```
giveaway <subcommand> <arg0> <arg1> ...
```

### Examples

- `{{execCC $CCID_for_giveaway_cc nil 0 "-giveaway start 1d Coins -w 2"}}` is equivalent to `-giveaway start 1d Coins`
  Starts a giveaway in the same channel in which `execCC` is invoked with a duration of 1 day with max winners set to 2 and prize set to `Coins`.

- `{{execCC $CCID_for_giveaway_cc nil 0 "-givewaway end 11106339"}}` is equivalent to `-giveaway end 11106339`
  Ends the giveaway with ID `11106339` immediately and announces the winners.

## Author

This custom command package was written by [@Satty9361](https://github.com/Satty9361).
