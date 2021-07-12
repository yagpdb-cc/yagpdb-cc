---
title: Emote Filter
---

Triggers on emoji-only message chains and punishes the user.

More specifically, this command will allow a set number of emote-only messages to go through before deleting subsequent messages and tracking them in a log channel.
It uses a rolling time frame: every time the filter catches an emote-only message, the automod length is refreshed.
The regex trigger will capture any number of emotes in a row and with up to 2 characters on each side to prevent bypassing automod (such as an emote followed by a single period) but has enough wiggle room to allow a message such as "LOL :kek:".

You have the option to enable an automatic emote ban function based on assigning a role to the user, which will delete all emote-only messages for the duration of their ban rather than counting towards the filter.
We recommend disabling the `Use External Emoji` permission as an added incentive for nitro users to not get themselves emote banned.

:::note

YAGPDB cannot detect message edits; thus, users are able to send messages and then edit them to single emotes bypassing the filter.
There is nothing that can be done about this so it's not an issue of this command.

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `^.{0,2}(((<a?:[\w~]{2,32}:\d{17,19}>)|[\x{1f1e6}-\x{1f1ff}]{2}|\p{So}\x{fe0f}?[\x{1f3fb}-\x{1f3ff}]?(\x{200D}\p{So}\x{fe0f}?[\x{1f3fb}-\x{1f3ff}]?)*|[#\d*]\x{FE0F}?\x{20E3}).{0,2}|\s+)+$`

## Configuration

- `$length`<br />
  Duration of auto delete, in seconds.

- `$emoteDelete`<br />
  Number of emotes allowed before deletion.

- `$logEnable`<br />
  Whether or not logging is enabled.

- 📌 `$logChannel`<br />
  Channel to send logs. Only applies if `$logEnable` is `true`.

- `$banEnable`<br />
  Whether or not emote bans are enabled.

- 📌 `$banRole`<br />
  Role ID of the emote ban role.

- `$banTime`<br />
  Emote ban duration in seconds.

- `$banNum`<br />
  Number of emotes from a single user permitted before an emote ban.

- `$banWarn`<br />
  Number of emotes from a single user before sending a warning in DM. Use `0` to disable.

- `$banMsg`<br />
  Whether or not you have `Use External Emoji` permissions disabled in channels.

## Code

```go file=../../../src/moderation/emote_filter.go.tmpl

```

## Author

This custom command was written by [@dvoraknt](https://github.com/dvoraknt).
