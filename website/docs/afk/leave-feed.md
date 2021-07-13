---
title: Leave Feed
---

:::note

This code is optional - if you don't want AFK messages to be removed when users leave, just don't add it.
The other components of the AFK system will work fine without it.

:::

This code removes the AFK messages of users who have left the server, to keep your database usage low.

For more information about the AFK system, please see [this](overview) page.

## Trigger

This is _not_ a custom command! Rather, it's meant to be added to your **Leave Feed**.

## Code

```gotmpl file=../../../src/afk/leave_feed.go.tmpl

```

## Author

This code was written by [@jo3-l](https://github.com/jo3-l).
