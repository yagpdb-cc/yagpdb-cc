---
sidebar_position: 1
title: Overview
---

## Features

- Set AFK status with optional duration
- Notification in chat when an AFK member was mentioned
  - Estimated time of arrival, when set

## Installation

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. Additionally, we've documented how and where to add these scripts down below.

### Main Command

Add the [main command](main-cc) as a new custom command. The trigger is a RegEx trigger type with `\A` or `.*`.

:::tip

If you're short on CC space, you can append the code to your already existing `\A` or `.*` trigger. Please do so only once, though.

:::

Now take your time to read through the leading comment and decide if you want to remove the AFK status of users, once they send a message. If so, leave it as is, otherwise set the config variable to `false`, as follows:

#### Disable removeAfkOnMessage

```go {2}
{{/* Configuration values */}}
{{ $removeAfkOnMessage := false}}
{{/* End of configuration values */}}
```

### Leave Feed

This is entirely optional, however generally encouraged to keep your custom command database clean. Add the code [here](leave-feed) to your leave message, which you can find like this:

- Go to your control panel
- Open up the Feeds & Notifications tab
- Click on General
- Locate the leave message

Once you've found it, just append the code at the end - don't forget to save!

:::info

The AFK system is now set up and ready to use!

:::

## Author

This custom command system was written by [@DaviiD1337](https://github.com/DaviiD1337).
