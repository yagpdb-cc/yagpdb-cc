---
title: Starboard V1
---

:::note

There is a [newer version](starboard/overview) of the starboard system that has all of the features of this one. We recommend that you consider switching to it / using it over this one if possible.

:::

This command allows users to react to messages with stars. If it reaches a given amount, it will be sent in the starboard channel.

**Benefits over the starboard command provided in the documentation:**

- Updates star count with more stars using a single database text entry.
- Posts automatically removed when they fall below star threshold.
- Ability to use "anti-star" reactions similar to an upvote/downvote system to automatically remove posts unfit for starboard.

## Trigger

**Type:** `Reaction`<br />
**Additional options:** `Added + Removed Reactions`

## Configuration

- `$starEmoji`<br />
  Name of the star emoji.

- `$starLimit`<br />
  Threshold of stars needed for a message to be posted on the starboard.

- 📌 `$starboard`<br />
  Channel ID of the starboard channel.

- `$maxAge`<br />
  Maximum age of messages for stars to be considered for the starboard. Structure is `(mo)nth`, `(w)week`, `(d)ay`, `(h)our`.
  **Example:** `3d` => 3 days, `1mo` => 1 month.

- `$antiStarEnable`<br />
  Whether _anti-star_ counting should be enabled. Anti-stars count towards the total number of stars but in a negative manner instead. For example, if a message had 3 stars and 1 anti-star, the adjusted number of stars would be 2.

- `$antiStarEmoji`<br />
  The name of the anti-star emoji.

- `$antiStarExtra`<br />
  The number of additional anti-star reactions needed before removing a post. For example, if this value were `0` (the default), the post would be removed if it had the same number of anti-star reactions as stars.

## Code

```go file=../../../src/fun/starboard.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l) with contributions from [@dvoraknt](https://github.com/dvoraknt).
