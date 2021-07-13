---
title: Big Emoji v2
---

An improved version of the [original big emoji CC](big-emoji-v1). Has all the features of the original version, but also the following features:

- View emojis using message ID
- View emojis from other members' messages
- View reaction emojis
- Will generate a list of emojis (up to 25) to view if there are multiple targets.

:::note Moderation

While it's fun to view emojis other members are using this is also a moderation tool. It can often be difficult to see detailed emojis in messages or when used as reactions; being able to safely pull them into a staff channel can allow you to moderate things such as NSFW emojis without drawing attention to them. This also allows you to better view reactions while on mobile since Discord has made it near impossible to view reaction names and images.

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(be|big-?emo(te|ji))(\s+|\z)`

## Usage

- `-bigemoji <emoji>` - Views an enlarged version of the emoji provided.
- `-bigemoji <message-id>` - Views enlarged versions of emojis within the message provided. Should be in the same channel as the triggering command.
- `-bigemoji <message-id> -re` - Same as above, but views reaction emojis instead.
- `-bigemoji <link>` - Views enlarged versions of emojis within the message provided. Should be in a channel which YAGPDB has access to.
- `-bigemoji <link> -re` - Same as above, but views reaction emojis instead.
- `-bigemoji help` - Displays a help message similar to the above.

:::caution Limitations

Due to a few limitations some default emojis won't generate proper links or may be incorrect altogether. Most will work but some will not, sorry for any inconvenience.

Custom emojis are displayed in their actual image size, while default emojis are displayed in 72x72 as that is the largest size the Twemoji CDN provides in PNG format.

:::

:::tip Aliases

Instead of `bigemoji`, you can also use `be`, `bigemote`, `big-emote`, and `big-emoji`.

:::

## Code

```gotmpl file=../../../src/utilities/big_emoji_v2.go.tmpl

```

## Attribution

This command uses Twemoji images provided by the [official Twemoji project](https://github.com/twitter/twemoji), which are licensed under CC-BY 4.0.

## Author

This custom command was written by [@dvoraknt](https://github.com/dvoraknt).
