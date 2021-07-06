---
sidebar_position: 3
title: Reaction Handler
---

This command allows users to react to messages within the starboard channel with stars/anti-stars.

For more information about the starboard system, see [this](overview) page.

## Trigger

**Type:** `Reaction`<br />
**Additional options:** `Added + Removed Reactions`

:::note

This command should be set to _only run_ in your starboard channel in the channel restrictions.

:::

## Configuration

See the [starboard system overview](overview/#configuration) for in-depth information about configuration.

## Code

```go file=../../../../src/fun/starboard_v2/reaction_handler.go.tmpl

```

## Author

This custom command was written by [@dvoraknt](https://github.com/dvoraknt).
