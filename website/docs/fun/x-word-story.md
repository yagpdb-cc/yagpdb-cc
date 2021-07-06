---
sidebar_position: 23
title: X Word Story Game
---

This command manages an X word story game.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

:::note Restrictions

Set this command to _only run_ in your x-word-story channel in the channel restrictions.

:::

## Usage

- Just type the correct amount of words and write a story together :)

## Configuration

- `$words`<br />
  Number of words to be used in the x-word-story channel.

- 📌 `$ignored_roles`<br />
  Roles to ignore when checking whether a message posted in the channel is valid.

- `$twice`<br />
  Response when users attempt to write twice in a row.

## Code

```go file=../../../src/fun/x_word_story.go.tmpl

```

## Author

This custom command was written by [@SpecialEliteSNP](https://github.com/SpecialEliteSNP).
