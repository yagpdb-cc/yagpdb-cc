---
title: Custom Command to File
---

This command sends your custom command code(s) as a text file, rather than "plain" Discord messages, preserving tabs, markdown, etc.

You can specify more than one ID or trigger, and the bot will generate one file per input parameter. If none are provided, output will be the entire CC list.

:::note

The built-in `cc` command received a recent update that allows it to show code in file format as well: see the `-file` switch. However, it does not support showing multiple custom commands, which is where this command comes in handy.

:::

## Trigger

**Type:** `Command`<br />
**Trigger:** `cc2file`

## Usage

- `-cc2file <id_or_trigger...>` - Sends the custom command codes of all the custom commands provided.

### Example

```
-cc2file 10 "te st" 23
```

Sends the code for the custom command with the ID 10, the custom command with the trigger `te st`, and the custom command with the ID 23.

## Configuration

- `$limitTo5CCs`<br />
  Whether or not to limit the output to five custom commands, to prevent spam.

- `$CCInfo_MessageContent`<br />
  Whether or not the info for each custom command should be included in the message content.

- `$CCInfo_Attachment`<br />
  Whether or not the info for each custom command should be included in the attached file.

- `$blacklisted_CCIDs`<br />
  List of CCs to disallow showing code for using this command.

## Code

```go file=../../../src/utilities/cc2file.go.tmpl

```

## Author

This custom command was written by [@MatiasMFM2001](https://github.com/MatiasMFM2001).
