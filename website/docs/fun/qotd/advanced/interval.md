---
title: Interval
---

This command triggers the Main CC to post a new QOTD on an interval.

For more information about the QOTD system, see [the overview page](overview).

## Trigger

**Type:** `Hourly Interval`<br />
**Interval:** `24`
**Channel:** (any channel where YAGPDB has `Send Message` permission)

:::danger

You must set a channel for this command or it will not function. It can be any channel where YAGPDB has `Send Message` permission.

:::

:::note

Before saving this command, *disable it*, and do not enable again until after you have completed the [interactive setup](overview/#configuration).

:::

## Configuration

All configuration is done via the `qotd setup` command. Only run this command after installing all four CCs in the QOTD
system. See the [QOTD system overview](overview/#configuration) for more information.

## Code

```gotmpl file=../../../../../src/fun/qotd/advanced/interval.go.tmpl

```

## Author

This custom command was written by [@SoggySaussages](https://github.com/SoggySaussages).
