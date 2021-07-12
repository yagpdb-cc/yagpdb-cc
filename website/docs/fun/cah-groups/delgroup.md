---
title: Delete Group
---

This command deletes a group of CAH card packs.

For more information about the CAH card pack system, see [this](overview) page.

## Trigger

**Type:** `Command`<br />
**Trigger:** `delgroup`

## Usage

- `-delgroup <group-name>` - Deletes the CAH card pack with the given name.

:::tip

If your group name has spaces in it, you need to put quotes around it: `-delgroup "group name"`.

:::

## Code

```go file=../../../../src/fun/cah_groups/delgroup.go.tmpl

```

## Author

This custom command was written by [@LRitzdorf](https://github.com/LRitzdorf).
