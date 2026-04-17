---
title: Export CCs
---

Export all custom commands in the server as files with additional metadata.

:::tip

Executing this script in a ticket channel allows you to instruct YAGPDB.xyz to bundle all of the exported files in a zip archive!

:::

## Trigger

**Type:** `Command`<br />
**Trigger:** `export-ccs`

## Configuration

- `$permissions`<br />
  The triggering user must have at least one of the listed permissions to run the export CCs command.

## Code

```gotmpl file=../../../src/utilities/export-ccs.go.tmpl

```

## Author

This custom command was written by [@galen8183](https://github.com/galen8183).
