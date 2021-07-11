---
sidebar_position: 9
title: Flag Message
---

This command allows users to flag messages for staff review through reactions.

## Trigger

**Type:** `Reaction`<br />
**Additional options:** `Added reactions only`

## Configuration

- 📌 `$reportEmoji`<br />
  ID of the report emoji.

  :::note

  This system only supports using custom emojis for now. Support for default Discord emojis may be added in a future update.

  :::

- 📌 `$reportChannel`<br />
  Channel to post flagged messages.

## Code

```go file=../../../src/utilities/flag_message.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
