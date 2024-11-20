---
title: FixupX Reminder
---

Replies with fixupx.com links to messages containing x.com links.

## Trigger

**Type:** `Regex`<br />
**Trigger:** `https:\/\/x\.com(?:\/[^\s]*)?`<br />

## Usage

Post any message with a link to [x.com](https://x.com/).

### Example

```txt
Check out this Tweet! https://x.com/rickastley/status/890617797956456448
```

## Configuration

In the custom command control panel, configure the command as follows:

**Trigger type:** `Contains`  
**Trigger:** `https://x.com`

## Code

```gotmpl file=../../../src/utilities/fixupx.go.tmpl

```

## Author

This custom command was written by [@laforcem](https://github.com/laforcem).
