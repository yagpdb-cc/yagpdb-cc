---
title: Mock Text
---

This command mocks text which is given (capitalizes every second letter, small-cases all other letters).

## Trigger

**Type:** `Command`<br />
**Trigger:** `mock`

## Usage

- `-mock <text>` - Mocks the text given.

### Example

```
-mock hello world
```

Results in `hElLo WoRlD`.

## Code

```gotmpl file=../../../src/fun/mock.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
