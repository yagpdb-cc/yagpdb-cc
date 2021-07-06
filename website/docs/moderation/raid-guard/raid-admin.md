---
sidebar_position: 2
title: Raid Admin
---

This command provides staff commands to mass action members suspected to be part of a raid.

For more information about the raid guard system, see [this](overview) page.

## Trigger

**Type:** `Command`<br />
**Trigger:** `raid`

## Usage

- `-raid <action>` - Runs the provided action on all members suspected to have been part of the raid.
  `action` must be one of `ban` or `kick`.
- `-raid clear` - Dismisses the report and clears the raid list.

:::note

The command may take a bit to finish running, as it has to run the action on all members.

:::

## Code

```go file=../../../../src/moderation/raid_guard/raid_admin.go.tmpl

```

## Author

This custom command was written by [@ENGINEER15](https://github.com/engineer152/).
