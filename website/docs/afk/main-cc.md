---
sidebar_position: 2
title: Main CC
---

This command allows users to set an AFK message with optional duration.

For more information about the AFK system, please see [this](overview) page.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

## Usage

- `-afk <message>` - To set an AFK message with no expiration.
- `-afk <message> -d <duration>` - To set an AFK message that expires in _duration_ time.

## Configuration

See the [AFK system overview](overview/#installation) for instructions regarding how to configure this command.

## Code

```go file=../../../src/afk/afk.go.tmpl

```

## Author

This custom command was written by [@DaviiD1337](https://github.com/DaviiD1337).
