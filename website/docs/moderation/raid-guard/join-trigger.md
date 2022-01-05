---
title: Join Trigger
---

This code tracks incoming members to a server. If their account age is less than some value (1 day by default), they are added to the raid list.
If the raid list exceeds some number, a notification is sent in a staff channel warning about a possible raid.

For more information about the raid guard system, see [this](overview) page.

:::note

Every 10 minutes, the list resets to account for any members not part of a raid.

:::

## Trigger

This is _not_ a custom command! Rather, it's meant to be added to your **Join Feed**.

## Configuration

- `$age`<br />
  Account age threshold for members to be added to the raid list **in minutes**.

- `$len`<br />
  Length of the raid list at which a notification is sent.

- 📌 `$rolemention`<br />
  List of role IDs to mention if a possible raid is detected.

- 📌 `$channel`<br />
  Channel to send notifications in if a possible raid is detected.

## Code

```gotmpl file=../../../../src/moderation/raid_guard/join_trigger.go.tmpl

```

## Author

This custom command was written by [@ENGINEER15](https://github.com/engineer152/).
