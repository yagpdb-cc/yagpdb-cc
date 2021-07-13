---
title: Send Message
---

This command is a tool for sending messages through YAGPDB, with embed support.

:::note Differences between this and `simpleembed`

This command is very similar to the built-in `simpleembed` command, but differs in that it allows you to add fields to the embed.
See [this section](#specifying-fields) for more information.

:::

## Trigger

**Type:** `Command`<br />
**Trigger:** `embed`

## Usage

`-embed <flags...>` - Sends a message using the flags provided.

The usage of this command is very similar to that of the `SimpleEmbed` built-in command; you specify certain flags to change parts of the message.

### Available Flags

#### Flags to modify message

:::caution

The flags used to create fields are documented separately, in [this section](#specifying-fields).

:::

| Flag                  | Description                                              | Example                                   |
| --------------------- | -------------------------------------------------------- | ----------------------------------------- |
| `-channel <channel>`  | Sets the channel where the message should be sent        | `-channel #my-channel`                    |
| `-color <decimal>`    | Sets the color of the embed; only supports decimal color | `-color 111111`                           |
| `-description <desc>` | Sets the description of the embed                        | `-description hello world`                |
| `-title <title>`      | Sets the title of the embed                              | `-title very cool`                        |
| `-image <url>`        | Sets the image URL of the embed                          | `-image https://i.imgur.com/vfbFEif.jpeg` |
| `-thumb <url>`        | Sets the thumbnail URL of the embed                      | `-thumb https://i.imgur.com/vfbFEif.jpeg` |
| `-author <name>`      | Sets the author name of the embed                        | `-author foo`                             |
| `-footer <text>`      | Sets the footer text of the embed                        | `-footer bar`                             |
| `-timestamp`          | Sets the timestamp of the embed to the current time      | `-timestamp`                              |

#### Specifying fields

At any point in the command, you can enter _field mode_ by using `-fields`.
After that, you use a combination of the following flags to specify the current field:

- `/name <name>` - Sets the name of the field.
  **Example:** `/name foo bar`

- `/value <value>` - Sets the value of the field.
  **Example:** `/value baz buz`

- `/inline <bool>` - Specifies whether the field should be inline.
  **Example:** `/inline true`

### Examples

#### Create simple embed

```
-embed -channel #channel -color 111 -title hello world -footer foo bar -description bar buz
```

Creates a new embed in channel `#channel` with the color `111`, title `hello world`, footer text `foo bar`, and description `bar buz`.

#### Create embed with fields

```
-embed -color 111 -title hello world -fields /name field name 0 /value field value 0 /inline true -fields /name field name 1 /value field value 1 /inline false
```

Creates a new embed in the current channel with the color `111`, title `hello world`, and two fields.
The first is inline and has the name `field name 0` and the value `field value 0`.
The second is not inline and has the name `field name 1` and the value `field value 1`.

## Code

```gotmpl file=../../../src/utilities/send.go.tmpl

```

## Author

This custom command was written by [@Pedro-Pessoa](https://github.com/Pedro-Pessoa).
