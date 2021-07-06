---
sidebar_position: 2
title: Main CC
---

This custom command adds birthday functionality to your server, wishing members all the best on their respective date.

For more information about the birthday system, see [this](overview) page.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A\-(my|start|stop|set|get|del)b(irth)?days?`

## Usage

Commands and usage is outlined in the [birthday system overview](overview/#commands).

## Configuration

Again, see the [birthday system overview](overview/#configuration) for instructions regarding how to configure this command.

## Code

```go file=../../../src/birthday/birthday.go.tmpl

```

## Author

This custom command was written by [@Pedro-Pessoa](https://github.com/Pedro-Pessoa).
