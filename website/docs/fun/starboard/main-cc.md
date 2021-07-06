---
sidebar_position: 2
title: Main CC
---

This command allows users to react to messages with stars. If the number of stars reaches a given amount, it will be sent in the starboard channel.

For more information about the starboard system, see [this](overview) page.

## Trigger

**Type:** `Reaction`<br />
**Additional options:** `Added + Removed Reactions`

:::note

This command should be set to _ignore_ your starboard channel in the channel restrictions.

:::

## Configuration

See the [starboard system overview](overview/#configuration) for more information regarding how to configure this command.

## Code

```go file=../../../../src/fun/starboard_v2/starboard.go.tmpl

```

## Author

This custom command was written by [@dvoraknt](https://github.com/dvoraknt).
