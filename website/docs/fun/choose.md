---
sidebar_position: 6
title: Choose Item
---

This command chooses an item from the ones provided.

## Trigger

**Type:** `Command`<br />
**Trigger:** `choose`

## Usage

- `-choose <...items>` - Choose an item from the ones provided. If an item has spaces in it, put quotes around it.

### Example

```
-choose "go to sleep" eat "watch tv"
```

Would result in one of `go to sleep`, `eat`, or `watch tv`.

## Code

```go file=../../../src/fun/choose.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
