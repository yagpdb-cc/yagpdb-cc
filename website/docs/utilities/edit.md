---
sidebar_position: 8
title: Edit Message
---

This command is a tool for editing messages sent by YAGPDB, with embed support.

## Trigger

**Type:** `Command`<br />
**Trigger:** `edit`

## Usage

`-edit [channel] <msg> <flags...>` - Edits the message provided.

The usage of this command is very similar to that of the `SimpleEmbed` built-in command. You specify a channel (defaulting to the current channel), a message, and some flags to specify which fields to edit.

### Available Flags

#### Flags to edit message

| Flag                 | Description                                          | Example                                            |
| -------------------- | ---------------------------------------------------- | -------------------------------------------------- |
| `-content <content>` | Sets the content of the message                      | `-content hello world`                             |
| `-title <title>`     | Sets the title of the embed in the message           | `-title new title`                                 |
| `-desc <desc>`       | Sets the description of the embed in the message     | `-desc my desc`                                    |
| `-image <url>`       | Sets the image URL of the embed in the message       | `-image https://i.imgur.com/vfbFEif.jpeg`          |
| `-thumbnail <url>`   | Sets the thumbnail URL of the embed in the message   | `-thumbnail https://i.imgur.com/vfbFEif.jpeg`      |
| `-url <url>`         | Sets the URL of the embed in the message             | `-url https://www.youtube.com/watch?v=oHg5SJYRHA0` |
| `-author <name>`     | Sets the author name of the embed in the message     | `-author foo`                                      |
| `-authoricon <url>`  | Sets the author icon of the embed in the message     | `-authoricon https://i.imgur.com/vfbFEif.jpeg`     |
| `-footer <text>`     | Sets the footer text of the embed in the message     | `-footer bar baz`                                  |
| `-footericon <url>`  | Sets the footer icon URL of the embed in the message | `-footericon https://i.imgur.com/vfbFEif.jpeg`     |
| `-color <hex>`       | Sets the color of the embed in the message           | `-color FF0000`                                    |

#### Flags to modify edit behaviour

- `-force` - Completely overwrites the existing message. By default, the changes are merged into the existing message - for example, `-edit 123 -color FF0000` would just edit the color and keep the embed. However, by supplying the `-force` flag, `-edit 123 -color FF0000 -force` would remove any other parts of the embed, keeping only the new color.

- `-clrembed` - Removes the embed from a message previously containing an embed, such that it only contains the content.

### Examples

#### To edit embed

```
-edit #channel 123 -title My new title -url https://www.youtube.com/watch?v=oHg5SJYRHA0
```

Would edit the message with ID `123` in channel `#channel` to have embed title `My new title` and set the embed URL to `https://www.youtube.com/watch?v=oHg5SJYRHA0`.

#### To completely overwrite

```
-edit 123 -title foo -desc bar -force
```

Would edit the message with ID `123` in current channel to have embed title `foo` and description `bar`, removing any other parts of the embed or message content.

## Code

```go file=../../../src/utilities/edit.go.tmpl

```

## Author

This custom command was written by [@Satty9361](https://github.com/Satty9361).
