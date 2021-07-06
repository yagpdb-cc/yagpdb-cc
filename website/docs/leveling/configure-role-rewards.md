---
sidebar_position: 2
title: Configure Role Rewards
---

This command allows administrators to manage role rewards.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(role-?rewards|rr)(\s+|\z)`

:::caution

Unless you would like everyone to be able to configure role rewards, we advise that you restrict this command to a staff role in the role restrictions.

:::

## Usage

:::tip

You can view a similar help message to the following in Discord by running `-rr` with no arguments.

:::

- `-rr add <level> <role_name>` - Adds a role reward to `level`. `level` must be between 1 and 100, and there can be at max 1 role reward per level.
- `-rr remove <level>` - Removes the role reward for the level provided, if it exists.
- `-rr set-type <'stack'|'highest'>` - Sets the mode in which role rewards are given to users.
  - `stack` means that role rewards will _stack_, hence the name: users will keep all the role rewards that they are eligible for.
  - `highest` means that the user will only keep the role reward for the highest level they have attained so far.
- `-rr reset` - Resets the role reward settings.
- `-rr view` - Views the current role reward setup.

:::note Aliases

Instead of `rr`, you can also use `rolerewards` or `role-rewards`.

:::

## Code

```go file=../../../src/leveling/role_rewards.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
