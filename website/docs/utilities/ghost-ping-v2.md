---
sidebar_position: 11
title: Ghost-Ping Detector v2
---

Version two of the ghost ping detector. Has all the features of the original in addition to the ability to send logs when a ghost ping is detected.

:::tip Ghost pings

A ghost ping is when you mention a user and then delete the message, leaving a ping that cannot be found: hence the term "ghost ping".

:::

:::note

This command only works if the ghost ping was deleted within 5 seconds of being sent (or 10 seconds if [`$CHECK` is enabled](ghost-ping-v2/#configuration)).

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `<@!?\d{17,19}>` or `\A`.

## Configuration

- `$CHECK`<br />
  Whether to schedule two `execCC` checks. The way this command works is that it checks after 5 seconds whether the message was deleted. This does mean that if you delete the message more than 5 seconds after message creation, this CC won't catch it by default.

  By enabling this option, the command will check twice instead of once, meaning that messages deleted between 5 and 10 seconds of being sent will be caught as well.

- `$LOG`<br />
  Whether message logs should be sent in the channel when ghost pings are detected.

## Code

```go file=../../../src/utilities/ghostping_v2.go.tmpl

```

## Author

This custom command was written by [@devnote-dev](https://github.com/devnote-dev).
