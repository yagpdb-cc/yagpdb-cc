---
title: Animal Image Generator
---

This command generates random images of different animals.

## Trigger

**Type:** `Command`<br />
**Trigger:** `animal`

## Usage

- `-animal <type>` - Generates an image of the animal given. `type` should be one of `duck`, `fox`, `cat`, `goat`, `shiba`, and `httpcat`.
- `-animal httpcat <code>` - Special case for httpcat images. Provide a HTTP status code as the second parameter to generate a httpcat image for that status code.

## Code

```go file=../../../src/fun/animal.go.tmpl

```

## Author

This custom command was written by [@GenryMg](https://github.com/hng12).
