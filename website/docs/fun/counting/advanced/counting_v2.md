---
title: Counting System
---

This command implements a counting game with detailed statistics and a leaderboard.

A unique feature of this command is that, besides decimal numbers, it also accepts roman numerals and mathematical expressions as valid inputs. So if the next number is 2, `II` and `2*sin(pi/2)` would be considered correct as well.

:::note

Unlike some other counting systems, this command does not delete invalid expressions to allow counting and other conversation to take place concurrently. Expressions which include unaccepted terms or are invalid will, however, trigger a warning message.

:::

The expression must appear on the first line entirely on its own for the count to increase.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `.+`

:::note Restrictions

Set this command to _only run_ in your counting channel in the channel restrictions.

:::

## Usage

- Type a number, roman numeral, or a mix of both... with the option of math incrementing by 1, starting with 1, in the counting channel!
- `-CountingStatistics` - Show server stats for counting
- `-CountingStatistics <user>` - Show user stats for counting
- `-CountingStatistics Leaderboard` - Show server leaderboard for number of times counted correct by each user

:::tip Math Functionality

To view all available math functions, see [Supported Functions, Operators, and Constants](https://github.com/ei14/calc#supported-functions-operators-and-constants)

:::

## Configuration

- `$countTwice`<br />
  Whether to allow users to count multiple times in a row.

- `$correctRID`<br />
  ID of role for most recent correct counting user.

- `$incorrectRID`<br />
  ID of role for incorrect counting users.

- `$errorCID`<br />
  ID of channel for any error output.

- `$saves`<br />
  Amount of incorrect expressions which can be sent before the count resets.

- `$reactions`<br />
  Whether to enable or disable reaction confirmation.

  - `$reactionDelete`<br />
    Whether reactions from past messages should be removed.

  - `$correctEmoji`<br />
    Emoji to react with on correct messages.

  - `$warningEmoji`<br />
    Emoji to react with on incorrect messages that use a save.

  - `$incorrectEmoji`<br />
    Emoji to react with on incorrect messages.

- `$leaderboardLength`<br />
  Max amount of users that should be displayed on the leaderboard.

## Code

```gotmpl file=../../../src/fun/counting/advanced/counting_v2.go.tmpl

```

## Author

This custom command was written by [@H1nr1](https://github.com/H1nr1).
