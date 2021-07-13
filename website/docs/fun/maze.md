---
title: Maze Generator
---

This command generates a maze image with an optional number of crossings/bridges. It also includes a link to a downloadable solution and `execCC` support.

## Trigger

**Type:** `Command`<br />
**Trigger:** `maze`

## Usage

- `-maze` - Generates a maze with 0 crossings.
- `-maze <crossings>` - Generates a maze with the given number of crossings.

:::tip `execCC` usage

To trigger the command via execCC, just call the CC with data set to the number of crossings.

:::

## Code

```gotmpl file=../../../src/fun/maze.go.tmpl

```

## Author

This custom command was written by [@Crenshaw1312](https://github.com/Crenshaw1312).
