---
title: View Leaderboard
---

This command displays a paginated leaderboard where users with higher experience come first.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(leaderboard|lb|top)(\s+|\z)`

## Usage

- `-leaderboard` - Views the first page of the leaderboard.
- `-leaderboard <page>` - Views a specific page of the leaderboard.

:::info Aliases

Instead of using `leaderboard`, you can also use `lb` or `top`.

:::

## Code

```go file=../../../src/leveling/leaderboard.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
