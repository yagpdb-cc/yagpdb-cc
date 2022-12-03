## Features

- Continuously count *forever*
- Toggle whether users can count multiple times in a row; or just once, until another user counts
- Assign a counting role to the current user
- Toggle second chance: one-time save of the count
- Customizable correct, warning, and incorrect emojis for reaction
- Visual statistics including server, user, and leaderboard

## Installation

This package contains two custom commands: the [main command](https://github.com/H1nr1/yagpdb-cc/blob/master/src/fun/counting/main.go.tmpl), and [statistics](https://github.com/H1nr1/yagpdb-cc/blob/master/src/fun/counting/stats.go.tmpl).

::: tip

The [statistics command](https://yagpdb-cc.github.io/fun/counting-v2/stats) is optional to add.

:::

## Main Command

Add the [main command](https://github.com/H1nr1/yagpdb-cc/blob/master/src/fun/counting/main.go.tmpl) as a new custom command. The trigger is a regex trigger type with value `^\d+|\(`.

::: caution

Use channel restrictions to restrict this custom command to your counting channel.

:::

## Statistics

Add [statistics](https://github.com/H1nr1/yagpdb-cc/blob/master/src/fun/counting/stats.go.tmpl) as a new custom command. The trigger is a command type with value `CStats`.

:::info

If you would like to customize the commands, see [here](overview/#configuration). For how to use it, please refer to the [usage](overview/#usage) section.

:::

## Configuration

There are many configurable values in this package, to which **only one must to be configured**: [$Admin](https://github.com/H1nr1/yagpdb-cc/edit/master/website/docs/fun/counting/overview.md#list-of-configurable-variables)

### List of Configurable Variables

- 📌 `$Admin`<br />
Administrator role ID; use for initializing command

- `$CountTwice`<br />
Allow users to count multiple times in a row; `true/false`

- `$RoleID`<br />
Counting role ID; set to `false` to disable

- `$SecondChance`<br />
Second chance if wrong; `true/false`

- `$StatsCC`<br />
If you added the [Stats CC](https://github.com/H1nr1/yagpdb-cc/blob/master/src/fun/counting/stats.go.tmpl); `true/false`

- `$Reactions`<br />
Allow confirmative reactions on message; `true/false`

  - `$ReactionDelete`<br />
  Toggle for reactions to delete from last message; `true/false`
  - `$CorrectEmoji`<br />
  Emoji to react with if number is correct; if custom, use format `name:id`
  - `$WarningEmoji`<br />
  Emoji to react with if wrong number AND Second Chance is `true/on`; if custom, use format `name:id`
  - `$IncorrectEmoji`<br />
  Emoji to react with if number is incorrect; if custom, use format `name:id`

- `$LBLength`<br />
How many members to show on leaderboard; MAX OF 100


## Usage

### Main Command

:::caution Initialization

Set `$Admin` to an administrator role ID, then send: 0

This initializes all database values and sets the count to 1

:::

Simply count 1 2 3 . . . 

Also accepts math!

### Statistics (CStats) Command

:::tip

The statistics command has an inbuilt help message which you can view by running `-CStats` with an invalid argument.

Example: `-CStats Test`

:::

This command accepts one argument, but has multiple responses depending on this argument.

`CStats` presents server counting statistics including: current score, high score with date and user, last user, and saves remaining

`CStats [String: Me/My/0]` presents triggering user's counting statistics including: total times counted, correct times counted, and your average

`CStats [User: @/ID]` presents mentioned user's counting statistics

`CStats [String: Leaderboard/LB]` presents server counting leaderboard of users with most correct

## Author

This custom command was written by [@H1nr1](https://github.com/H1nr1)
