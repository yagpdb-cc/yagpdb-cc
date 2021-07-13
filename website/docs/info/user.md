---
title: View User Info
---

This command views information about a user, defaulting to the triggering user.

:::note Differences between this and `whois`

This command is quite similar to `whois` but also shows the user's role and uses their display colour. Other than that, there's not much of a difference. It's mainly here for consistency with the other informational commands.

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(user|member)(-?info)?(\s+|\z)`

## Usage

- `-user` - Views information about yourself.
- `-user <user>` - Views information about the user provided.

:::tip Aliases

Instead of `user`, you can also use `member`, `memberinfo`, `member-info`, `userinfo`, or `user-info`.

:::

## Code

```gotmpl file=../../../src/info/user.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
