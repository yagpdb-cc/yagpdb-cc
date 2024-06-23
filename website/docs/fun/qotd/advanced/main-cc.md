---
title: Main CC
---

This command holds the majority of the QOTD system's code, managing the QOTD channel, posting new questions, the queue,
and any text commands from users.

For more information about the QOTD system, see [the overview page](overview).

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

:::note

For best results, do not restrict this command's channels or roles.

:::

## Configuration

All configuration is done via the `qotd setup` command. Only run the setup command after installing all four CCs in the QOTD
system. See the [QOTD system overview](overview/#configuration) for more information.

## Code

```gotmpl file=../../../../../src/fun/qotd/advanced/qotd.go.tmpl

```

## Author

This custom command was written by [@SoggySaussages](https://github.com/SoggySaussages).
