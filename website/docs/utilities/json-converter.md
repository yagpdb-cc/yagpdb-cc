---
sidebar_position: 12
title: JSON Converter
---

This command displays information about messages. In particular, it shows parts of the message in JSON, hence the name.

## Trigger

**Type:** `Command`<br />
**Trigger:** `json`.

## Usage

- `-json <channel|'0'> <message>` - Displays information about the message provided. `0` denotes current channel.

### Optional Flags

- `-f` - Displays message attachments.
- `-j` - Uses a cleaner format for the message JSON.

## Code

```go file=../../../src/utilities/json.go.tmpl

```

## Author

This custom command was written by [@devnote-dev](https://github.com/devnote-dev).
