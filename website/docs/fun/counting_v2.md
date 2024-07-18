---
title: Counting System
---

This command controls the counting game and the statistics command.

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
  Amount of saves from incorrect counts before the count resets.

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

```gotmpl file=../../../src/fun/counting_v2.go.tmpl

```

## Author

This custom command was written by [@H1nr1](https://github.com/H1nr1).
