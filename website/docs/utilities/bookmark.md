---
title: Bookmark Message
---

This command functions similar to the reminder command, but sends a DM instantly.
Alternatively, one could see it as a private pin command.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(?:-\s?|<@!?204255221017214977>\s*)b(?:ook)?m(?:ark)?(?:\s+|\z)`<br />

## Usage

- `-bookmark <message>` - Sends a nicely formatted note with the message provided in DM.

:::note Aliases

Instead of `bookmark`, you can also use `bm`.

:::

## Code

```go file=../../../src/utilities/bookmark.go.tmpl

```

## Author

This custom command was written by [@l-zeuch](https://github.com/l-zeuch).
