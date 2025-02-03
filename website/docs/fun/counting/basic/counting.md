---
title: Counting System
---

This command runs the counting game.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

:::note Restrictions

Set this command to _only run_ in your counting channel in the channel restrictions.

:::

## Usage

- Type a number in the counting chat to begin the game!
  - You can't count twice in a row.
- Run `resetcount` to reset the count (staff only).

## Configuration

- `$emoji`<br />
  Emoji to be added to the latest correct count.

- `$wrong`<br />
  Response when users get the count wrong.

- `$twice`<br />
  Response when users attempt to count twice in a row.

- `$1000_ntf`<br />
  Milestone notification for every 1000 numbers counted.

- `$100_ntf`<br />
  Milestone notification for every 100 numbers counted.

- `$change_msg`<br />
  Informational message to be sent when the latest correct count was changed.

- `$warn_on_del`<br />
  Whether to warn when a member deletes their latest correct count.

- `$warn_msg`<br />
  Warning message for the above option.

- 📌 `$staff_roles`<br />
  List of role IDs to ignore when trying to warn members. Also, only users with one of these roles can run the `resetcount` command.

## Code

```gotmpl file=../../../src/fun/counting/basic/counting.go.tmpl

```

## Author

This custom command was written by [@SpecialEliteSNP](https://github.com/SpecialEliteSNP).
