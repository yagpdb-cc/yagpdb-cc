---
title: Snipe Message
---

Retrieves the most recently deleted message in the past hour (non-premium) / 12 hours (premium).

## Trigger

**Type:** `Command`<br />
**Trigger:** `snipe`

## Usage

- `-snipe` - Retrieves the most recently deleted message in the past hour (non-premium) / 12 hours (premium).

## Configuration

- `$REDACT_INVITES` <br />
  Whether or not to remove invites from messages when displaying deleted message.

## Code

```gotmpl file=../../../src/utilities/snipe.go.tmpl

```

## Author

This custom command was written by [zen | ゼン](https://github.com/z3nn13).
