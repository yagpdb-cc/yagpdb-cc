---
title: Meme Generator
---

This command generates a meme using a template and top/bottom text.

## Trigger

**Type:** `Command`<br />
**Trigger:** `meme`

## Usage

- `-meme <template> <top-text> <bottom-text>` - Generates a meme using the template, top text and bottom text provided. The template may be either `both`, `buzz`, `doge`, `joker`, or `sad-biden`.
- `-meme custom <top-text> <bottom-text> <image-link>` - Generates a meme using the image, top text and bottom text provided. Instead of an image link, you may also attach an image to the message.

:::caution Special characters

Sometimes, special characters will mess up the link, so we advise that you only use the following special characters in the top/bottom text: ` `, `?`, `%`, `#` or `/`.

:::

## Code

```gotmpl file=../../../src/fun/meme.go.tmpl

```

## Author

This custom command was written by [GenryMg](https://github.com/hng12).
