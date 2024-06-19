---
title: Main CC
---

This command sends anonymous messages and maintains the sticky message with the anonymous message submit button.

For more information about the anonymous channel, see [the overview](overview) page.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

:::danger

This command should be set to _only run in_ your anonymous channel in the channel restrictions.

:::

## Configuration

See the [anonymous channel overview](overview/#configuration) for more information regarding how to configure this command.

## Code

```gotmpl file=../../../../src/fun/anon_channel/anon.go.tmpl

```

## Author

This custom command was written by [@soggysaussages](https://github.com/SoggySaussages).
