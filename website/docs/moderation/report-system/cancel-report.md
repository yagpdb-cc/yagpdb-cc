---
sidebar_position: 3
title: Cancel Report
---

This command handles report cancellation requests for the custom report system.

For more information about the custom report system, see [this](overview) page.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A-c(ancel)?r(eport)?(\s+|\z)`

## Usage

- `-cr <id> <key> <reason>` - Cancels the report with the ID provided using the user's secret key and the reason given.

:::tip

The values for the ID and key parameters are sent to users in DM when they run the report command.

:::

:::info Aliases

Instead of `cr`, you can also use `cancelreport`, `cancelr`, or `creport`.

:::

## Code

```go file=../../../../src/moderation/report_system/cancel_report.go.tmpl

```

## Author

This custom command was written by [@l-zeuch](https://github.com/l-zeuch).
