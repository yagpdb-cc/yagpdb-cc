---
title: Component Handler
---

This command handles all button pushes and select menu usage during setup and actual usage of the QOTD system.

For more information about the QOTD system, see [the overview page](overview).

## Trigger

**Type:** `Component`<br />
**Custom ID:** `\Aqotd-`

:::note

For best results, do not restrict this command's channels or roles.

:::

## Configuration

All configuration is done via the `qotd setup` command. Only run the setup command after installing all four CCs in the QOTD
system. See the [QOTD system overview](overview/#configuration) for more information.

## Code

```gotmpl file=../../../../../src/fun/qotd/advanced/component_handler.go.tmpl

```

## Author

This custom command was written by [@SoggySaussages](https://github.com/SoggySaussages).
