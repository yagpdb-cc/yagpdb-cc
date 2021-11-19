---
title: Ticket Channel
---

Takes all messages sent in a specified channel, creates a ticket owned by the user who sent it and witht the message as the reason, and deletes the original message.

:::caution

Make sure you have the tickets system set up first.

:::

:::note

If you want a message in the tickets channel, send it before installing the custom command.

:::
## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`<br />
**Additional options:** Be sure to restrict it to only run in a specified channel


### Example
[![Example](https://spongebob.is-from.space/r/kw6rqwjbd0a.png)](https://og.blurple.rip/r/18_PM.webm "Example")


## Code

```gotmpl file=/src/utilities/ticket_channel.go.tmpl

```

## Author

This custom command was written by [@mrhappyma](https://github.com/mrhappyma).
