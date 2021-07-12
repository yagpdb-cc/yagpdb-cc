---
title: Set Group
---

This command creates a new group of CAH card packs, or edits an existing one.

For more information about the CAH card pack system, see [this](overview) page.

## Trigger

**Type:** `Command`<br />
**Trigger:** `setgroup`

## Usage

- `-setgroup <group-name> <packs>` - Creates a new group of CAH card packs, or overwrites an existing one.

:::note

The packs to form the specified group must all be in the same set of quotes. See the example below.

:::

### Example

```
-setgroup "group name" "20-blanks ai sanity"
```

Creates a new pack called `group name` that expands to the following packs: `20-blanks`, `ai`, `sanity`.

## Code

```go file=../../../../src/fun/cah_groups/setgroup.go.tmpl

```

## Author

This custom command was written by [@LRitzdorf](https://github.com/LRitzdorf).
