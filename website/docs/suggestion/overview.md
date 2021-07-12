---
title: Overview
---

A feature-rich suggestion system, condensed into a single custom command.
This is similar to the current system used in the YAGPDB Support Server.

## Features

- Logging channels
- Management commands
- Cooldown to prevent spam

## Installing

In case you need a refresher, or don't know how to add a custom command, please read this tutorial.

For now, we will just add the system to your server and elaborate later on the various configuration variables as well as commands and subcommands.

Copy the entire script from [the main cc](main-cc) and add it as a new custom command. Set the trigger type to RegEx and paste the following as the trigger:

```
(?i)\A(\-\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+((?:mark)?dupe|deny|implement(ed)?|archive|approved?|comment))(\s+|\z)
```

:::note

Make sure to replace the `-` at the beginning of the trigger with your server's prefix.

:::

You will not be able to save yet, as the custom command code is slightly over the limit as is. To fix this, we have to do one minor tweak: remove the large leading comment as well as the second comment:

##### What to remove

```diff
- {{/*
-	Main command for the suggestion system.
-	See <LINK> for more information.
-
-	Author: Satty9361 <https://github.com/Satty9361>
- */}}
-
- {{/* Configurable values */}}
{{$Suggestion_Channel:=737324313341853796}}
```

Remove the text you see here as red from your custom command. Now you can save, which you should definitely do.

## Configuration

Okay, there are still a few things to do before your suggestion system is set up, which are the configuration variables. Please take your time to read through their description before making any changes.

### Channels

:::note

Among these variables, all channels can be separate or the same.

:::

- 📌 `$Suggestion_Channel`<br />
  This is the main channel, where all suggestions made through the command will show up - This is the #suggestions channel on the support server.

- 📌 `$Logging_Channel`<br />
  This is the channel where the authors are notified if a suggestion was denied, approved, implemented, or marked as dupe.
  In the YAGPDB server, this is the `#suggestion-discussion` channel.

- 📌 `$Implemented_Channel`<br />
  The channel where suggestions which have been marked as implemented are sent.
  This provides a good way to organise all implemented suggestions into a separate channel.
  On the support server, you can find this channel as `#implemented-suggestions`.

- 📌 `$Approved_Channel`<br />
  Where approved suggestions are being sent to. This is not the same as implemented suggestions: you can see approved suggestions as "being worked on", and implemented suggestions as "this is now a feature". In the Support Server, we log those under `#implemented-suggestions` as well.

:::danger

Do not leave any channel ID blank, as this will break the system.

:::

### Other

- 📌 `$Mod_Roles`<br />
  List of all role IDs which should have access to the management commands explained further down. There is no need to specify the roles which have Administrator permission, they will gain automatic access. Separate the individual role IDs by spaces.

- `$Cooldown`<br />
  The cooldown in seconds between consecutive suggestions to prevent spam. Set this to `0` to disable, Mods and Admins will automatically bypass this.

- `$Upvote`<br />
  The emoji to use for upvoting a suggestion. Both inbuilt and custom emojis are supported. For custom emoji, use the `name:id` / `a:name:id format`. Otherwise, the corresponding unicode character. See below for an example.

- `$Downvote`<br />
  Same as above, however for downvoting a suggestion.

#### Examples

##### Upvote and Downvote example with unicode (inbuilt) emoji

```go
{{$Upvote:="👍"}}
{{$Downvote:="👎"}}
```

##### Upvote and Downvote example with custom emoji

```go
{{$Upvote:="upvote:524907425531428864"}}
{{$Downvote:="downvote:524907425032175638"}}
```

Configure the variables to your liking and save again.

:::info

Your suggestion system is now set up and ready for use!

:::

## Commands

:::tip

Precede all commands covered in the following sections either with your prefix or mention YAGPDB.

:::

This section documents the commands and subcommands of this system, along with their use-case and usage.

:::note

Required arguments are enclosed in `< >`, optional arguments in `[ ]`.

:::

### For everyone

- `suggest`<br />
  **Syntax:** `suggest <suggestion>`  
  **Use:** Used to submit a new suggestion.

- `deletesuggestion`<br />
  **Syntax:** `deletesuggestion <id>`  
  **Use:** Delete the suggestion with the given ID. Can be used by mods to force-delete a suggestion.

- `editsuggestion`<br />
  **Syntax:** `editsuggestion <id> <new_suggestion>`  
  **Use:** Edit the suggestion with the given ID. Replaces the old text entirely with the new text.

### For Mods / Admins

- `sa deny`<br />
  **Syntax:** `sa deny <id> [reason]`  
  **Use:** Deny a suggestion and notify the author that their suggestion has been deleted, along with the optional reason for denial.

- `sa dupe`<br />
  **Syntax:** `sa dupe <Suggestion-ID:Whole Number> <Old Suggestion-ID:Whole Number>`  
  **Use:** Mark the first given suggestion as a dupe of the second suggestion, delete the duplicate and inform the author of the duplicate.

- `sa approve`<br />
  **Syntax:** `sa approve <id> [comment]`  
  **Use:** Approve a suggestion and log it to the channel for approved suggestions and notify the author. Adds a record of who approved the suggestion.

- `sa implement`<br />
  **Syntax:** `sa implement <id> [comment]`  
  **Use:** Log a suggestion to the channel for implemented suggestions and notify the author. Sets a record of who implemented this suggestion.

- `sa comment`<br />
  **Syntax:** `sa comment <id> <comment>`  
  **Use:** Comment on a suggestion. Can be used on any kind of suggestion.

  :::caution

  If there is already a comment, this will override the old comment.

  :::

## FAQ

**Q: What is a suggestion ID?**<br />
**A:** This is just the message ID of the suggestion message. If you are unsure how to get message IDs, you can read [this](https://support.discord.com/hc/en-us/articles/206346498) Discord article.

**Q: I can't implement an approved suggestion! Why?**<br />
**A:** This is very likely because you copied the wrong message ID. Double check your input.

**Q: When I try to save, it errors with "response too long". What am I doing wrong?**<br />
**A:** You need to remove the first two comments, as shown [further up](#what-to-remove).

## Author

This custom command system was written by [@Satty9361](https://github.com/Satty9361).
