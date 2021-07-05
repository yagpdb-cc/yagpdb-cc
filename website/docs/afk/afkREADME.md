---
sidebar_position: 1
title: AFK System
sidebar_label: AFK Read Me
---

This package includes two custom commands, both of which you will have to add to your server.
In case you need a refresher, or don't know how to add a custom command, please read [this](https://learn.yagpdb.xyz/the-custom-command-interface) tutorial.

---

## Features

- Set AFK status with optional duration
- Notification in chat when an AFK member was mentioned
  - Estimated time of arrival, when set

---

## Installing

As usual, there are leading comments in each file describing where to put the script and which trigger to use. Additionally, we've documented how and where to add these scripts down below.

| ⚠ To be able to add custom commands, you need contol panel write access. |
| ------------------------------------------------------------------------ |

### Main Command

Add the main command [AFK CC](afkcc) as a new custom command. The trigger is a RegEx trigger type with `\A` or `.*`.  
Alternatively, you can append the code to your already existing `\A` or `.*` trigger. Please do so only once, though.  
Now take your time to read through the leading comment and decide if you want to remove the AFK status of users, once they send a message. If so, leave it as is, otherwise set the config variable to `false`, as follows:

#### Disable removeAfkOnMessage

```go
{{ $removeAfkOnMessage := false }}
```

### Leave Feed

This is entirely optional, however generally encouraged to keep your custom command database clean. Add the code in [leaveFeed](leaveFeed) to your leave message, which you can find like this:

- Go to your control panel
- Open up the Feeds & Notifications tab
- Click on General
- Locate the leave message

Once you've found it, just append the code at the end - don't forget to save!

| ✅ The AFK System is now set up and ready to use! |
| ------------------------------------------------- |

---

This custom command package was authored by [@DaviiD1337](https://github.com/DaviiD1337). If you are experiencing any problems, feel free to open up an [issue](https://github.com/yagpdb-cc/yagpdb-cc/issues) or ask in the [support server](https://discord.com/invite/4udtcA5).
