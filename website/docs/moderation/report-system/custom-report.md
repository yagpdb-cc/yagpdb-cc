---
title: Custom Report
---

This command is basically equivalent to the built-in report command, but has some back-end changes in order for the rest of the custom report system to work.

For more information about the custom report system, see [this](overview) page.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A-r(eport)?(?:u(ser)?)?(\s+|\z)`

## Usage

- `-ru <user> <reason>` - Reports the user provided using the reason given.

:::info Aliases

Instead of `ru`, you can also use `reportuser`, `reportu`, or `ruser`.

:::

## Configuration

- 📌 `$REPORT_LOG`<br />
  The channel where reports are sent to.

- 📌 `$REPORT_DISCUSSION`<br />
  The channel where users are notified of updates regarding their report.

## Code

```go file=../../../../src/moderation/report_system/custom_report.go.tmpl

```

## Author

This custom command was written by [@l-zeuch](https://github.com/l-zeuch).
