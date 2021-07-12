---
title: Question of the Day
---

This command helps you manage a "Question of the Day" channel. It will resend QOTD messages and sends automatic reports about the last day's QOTD to a channel of your choice once you create a new QOTD.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

:::note Restrictions

Set this command to _only run_ in your QOTD channel in the channel restrictions.

:::

## Usage

- Simply mention your Question of the Day role in the right channel with a message, e.g. `@QOTD what is your favourite food?`
  - The bot will then remove your message and re-send it.

## Configuration

- `$twice`<br />
  Warning message when users attempt to answer the QOTD twice.

- 📌 `$qotd_role`<br />
  ID of your question of the day role.

- 📌 `$staff_roles`<br />
  List of staff role IDs. Members with any of these roles are able to ask a QOTD. There is also an exception for answering a question twice.

- 📌 `$report_channel`<br />
  Channel to send the QOTD report to.

## Code

```go file=../../../src/fun/qotd.go.tmpl

```

## Author

This custom command was written by [@SpecialEliteSNP](https://github.com/SpecialEliteSNP).
