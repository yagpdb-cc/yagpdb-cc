## Features

- Continuously count *forever*
- Toggle whether users can count multiple time in a row; or just once, until another user counts
- Assign a counting role to the current user
- Toggle second chance: one-time save of the count
- Customizable correct, warning, and incorrect emojis for reaction
- Visual statistics including server, user, and leaderboard

## Installation

This package contains two custom commands: the [main command](main-cc), and [statistics](stats).

*The statistics command is not neccesary to add, but is a bonus.*

## Main Command

Add the [main command](main-cc) as a new custom command. The trigger is a regex trigger type with value `^(\d{1,}|\()`.

::: caution

Use channel restrictions to restrict this custom command to your counting channel.

:::

## Statistics

Add [statistics](stats) as a new custom command. The trigger is a command type with value `CStats`.

:::info

If you would like to customize the commands, see [here](overview/#configuration). For how to use it, please refer to the [usage](overview/#usage) section.

:::

### Configuration

There are many configurable values in this package, none need to be changed for the command to work properly.

Optional configuration values include: <sup>Main</sup> `$CountTwice` `$RoleID` `$Admin` `$SecondChance` `$Leaderboard` `$CorrectEmoji` `$WarningEmoji` `$IncorrectEmoji` <sup>Stats</sup> `$LBLength`

*How each of these values can be customly configured is described in the command itself*

## Usage

### Main Command

:::tip Initialization

There are two ways to initialize this command: 

1. Set `$Admin` to an administrator role ID in quotes, then send "0"
2. Count incorrectly for a rotation (until wrong/count resets)

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
