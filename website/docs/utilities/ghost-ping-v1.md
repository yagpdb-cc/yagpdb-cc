---
title: Ghost-Ping Detector v1
---

:::caution

If you are adding this command for the first time, consider looking at [version two](ghost-ping-v2) of the ghost-ping detector instead.

:::

This command detects ghost pings.

:::tip Ghost pings

A ghost ping is when you mention a user and then delete the message, leaving a ping that cannot be found: hence the term "ghost ping".

:::

:::note

This command only works if the ghost ping was deleted within 5 seconds of being sent (or 10 seconds if [`$CHECK` is enabled](ghost-ping-v1/#configuration)).

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `<@!?\d{17,19}>` or `\A`.

## Configuration

- `$CHECK`<br />
  Whether to schedule two `execCC` checks. The way this command works is that it checks after 5 seconds whether the message was deleted. This does mean that if you delete the message more than 5 seconds after message creation, this CC won't catch it by default.

  By enabling this option, the command will check twice instead of once, meaning that messages deleted between 5 and 10 seconds of being sent will be caught as well.

## Code

```go file=../../../src/utilities/ghostping_v1.go.tmpl

```

## Author

This custom command was written by [@devnote-dev](https://github.com/devnote-dev).
