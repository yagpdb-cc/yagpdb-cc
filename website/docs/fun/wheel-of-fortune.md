---
sidebar_position: 22
title: Wheel of Fortune
---

This command runs the wheel of fortune game.

:::caution

This command assumes that you have an existing currency system set up to provide credits to users.

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A\-(?i)wheel(offortune)?`

## Usage

- `wheeloffortune <bet>` - Runs the wheel of fortune game, betting `bet`.

:::tip Aliases

Instead of `wheeloffortune`, you can also use `wheel` and `wheelOfFortune` (the command is case insensitive).

:::

## Configuration

- 📌 `$dbName`<br />
  Database entry name that stores the user's credits.

- `$limit`<br />
  The message to show users when they don't have enough credits to play.

- `$bb1`<br />
  The message to show users when they attempt to bet less than 1 credit.

- `$helpText`<br />
  The help text for the command.

## Code

```go file=../../../src/fun/wheel_of_fortune.go.tmpl

```

## Author

This custom command was written by [@Hyakki999](https://github.com/Hyakki999).
