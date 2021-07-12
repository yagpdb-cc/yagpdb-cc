---
title: Configure Settings
---

This command allows administrators to configure general leveling settings.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(leveling|(level|lvl)-?conf|(level|lvl)-?settings)(\s+|\z)`

:::caution

Unless you would like everyone to be able to configure general leveling settings, we advise that you restrict this command to a staff role in the role restrictions.

:::

## Usage

:::tip

You can view a similar help message to the following in Discord by running `-leveling` with no arguments.

:::

- `-leveling set cooldown <duration>` - Sets the cooldown between giving messages.
- `-leveling set min <num>` - Sets the lower bound of the range of experience that can be given when a user sends a message.
- `-leveling set max <num>` - Sets the upper bound of the range of experience that can be given when a user sends a message.
- `-leveling set-channel <channel|'none'>` - Sets the channel where level-up announcements will be sent. The default is to send it in the channel where the user leveled up, but you can also set it to a fixed channel by providing a channel. To use the default of the channel where the user leveled up, use `none` as the channel.
- `-leveling set-announcements <bool>` - Sets whether level-up announcements should be sent.
- `-leveling view` - Views the current leveling settings.

:::info Aliases

Instead of using `leveling`, you can also use `levelconf`, `lvlconf`, `level-conf,` `lvl-conf`, `levelsettings`, `lvlsettings`, `level-settings`, or `lvl-settings`.

:::

## Code

```go file=../../../src/leveling/leveling.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
