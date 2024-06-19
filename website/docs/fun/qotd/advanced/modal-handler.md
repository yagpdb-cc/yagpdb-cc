---
title: Modal Handler
---

This command parses the modal submitted questions and triggers the Main CC to add them to the queue.

For more information about the QOTD system, see [the overview page](overview).

## Trigger

**Type:** `Modal`<br />
**Custom ID:** `\A0?qotd-`

:::note

For best results, do not restrict this command's channels or roles.

:::

## Configuration

All configuration is done via the `qotd setup` command. Only run this command after installing all four CCs in the QOTD
system. See the [QOTD system overview](overview/#configuration) for more information.

## Code

```gotmpl file=../../../../src/fun/qotd/advanced/modal_handler.go.tmpl

```

## Author

This custom command was written by [@SoggySaussages](https://github.com/SoggySaussages).
