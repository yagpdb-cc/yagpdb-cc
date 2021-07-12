---
title: Start New Game
---

This command starts a new CAH game using the specified packs and pack groups.
It first checks whether each argument is a valid pack group and, if so, expands it into its component packs. If not, that argment is assumed to be an individual pack and is skipped. After expanding all applicable pack groups, the resulting list of packs is used to start a new game, and all members with the CAH role are pinged.

For more information about the CAH card pack system, see [this](overview) page.

## Trigger

**Type:** `Command`<br />
**Trigger:** `newgame`

## Usage

- `-newgame <packOrPackGroups...>` - Starts a new CAH game using the specified packs and pack groups.
- `-newgame` - Starts a new CAH game using the default list of packs.

### Example

```
-newgame 40-blanks family-friendly packGroup1 "pack group 2"
```

Starts a new CAH game using the built-in packs `40-blanks` and `family-friendly` in addition to the CAH pack groups `packGroup1` and `pack group 2`, assumed to have been configured beforehand using `-setgroup`.

:::tip

There's no specific order that you have to put the pack/pack groups in: the above example would have worked with `-newgame family-friendly packGroup1 40-blanks "pack group 2"` as well.

:::

## Configuration

- `$packs`<br />
  Default list of packs to use if no arguments were provided. For example, setting this value to `"40-blanks family-friendly"` would use the packs `40-blanks` and `family-friendly` by default.

- 📌 `$CAHrole`<br />
  The ID of the CAH role, which will be pinged when a new game is started.

## Code

```go file=../../../../src/fun/cah_groups/newgame.go.tmpl

```

## Author

This custom command was written by [@LRitzdorf](https://github.com/LRitzdorf).
