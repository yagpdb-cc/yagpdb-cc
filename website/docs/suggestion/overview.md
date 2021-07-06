---
sidebar_position: 1
title: Overview
---

A feature-rich suggestion system, condensed into a single custom command.
This is similar to the current system used in the YAGPDB Support Server.

---

## Features

- Logging channels
- Management commands
- Cooldown to prevent spam

---

## Installing

In case you need a refresher, or don't know how to add a custom command, please read this tutorial.

For now, we will just add the system to your server and elaborate later on the various configuration variables as well as commands and subcommands.

Copy the entire script from [the main cc](main-cc) and add it as a new custom command. Set the trigger type to RegEx and paste the following as the trigger:

##### Suggestion System Trigger

```
(?i)\A(\-\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+((?:mark)?dupe|deny|implement(ed)?|archive|approved?|comment))(\s+|\z)
```

| ⚠ Make sure to replace the `-` at the beginning of the trigger with your server's prefix. |
| ----------------------------------------------------------------------------------------- |

You will not be able to save yet, as the custom command code is slightly over the limit as is. To fix this, we have to do one minor tweak: remove the large leading comment as well as the second comment:

##### What to remove

```diff
- {{/*
- 	This command is the main suggestion command with suggestion create/edit/delete
-   and suggestadmin commands. Usage: Refer README.md
-
-	Recommended trigger: Regex trigger with non case sensitive and trigger
-  `\A(\-\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+((?:mark)?dupe|deny|implement(ed)?|archive|approved?|comment))(\s+|\z)`
-   Note: If your prefix is not `-` replace the `-` at the start of the trigger with your prefix.
-	P.S. - REMOVE This comment so that you can save the command. Otherwise youll get an error!
- */}}
-
- {{/* CONFIGURATION AREA STARTS */}}
{{$Suggestion_Channel:=737324313341853796}}
```

Remove the text you see here as red from your custom command. Now you can save, which you should definitely do.

---

## Configuration

Okay, there are still a few things to do before your suggestion system is set up, which are the configuration variables. Please take your time to read through their description before making any changes.

### Channels

| ℹ Among these variables, all channels can be separate or the same. |
| ------------------------------------------------------------------ |

- `$Suggestion_Channel`  
  This is the main channel, where all suggestions made through the command will show up - This is the #suggestions channel on the support server.
- `$Logging_Channel`  
  This is the channel where the authors are notified if a suggestion was denied, approved, implemented, or marked as dupe. In the YAGPDB server, this is the `#suggestion-discussion` channel.
- `$Implemented_Channel`  
  The channel where suggestions which have been marked as implemented are sent. This provides a good way to organise all implemented suggestions into a separate channel. On the support server, you can find this channel as `#implemented-suggestions`.
- `$Approved_Channel`  
  Where approved suggestions are being sent to. This is not the same as implemented suggestions: you can see approved suggestions as "being worked on", and implemented suggestions as "this is now a feature". In the Support Server, we log those under `#implemented-suggestions` as well.

| 🛑 Do not leave any channel ID blank, as this will break the system. |
| -------------------------------------------------------------------- |

### Other

- `$Mod_Roles`  
  List of all role IDs which should have access to the management commands explained further down. There is no need to specify the roles which have Administrator permission, they will gain automatic access. Separate the individual role IDs by spaces.
- `$Cooldown`  
  The cooldown in seconds between consecutive suggestions to prevent spam. Set this to `0` to disable, Mods and Admins will automatically bypass this.
- `$Upvote`  
  The emoji to use for upvoting a suggestion. Both inbuilt and custom emojis are supported. For custom emoji, use the `name:id` / `a:name:id format`. Otherwise, the corresponding unicode character. See below for an example.
- `$Downvote`
  Same as above, however for downvoting a suggestion.

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

| ✅ Your suggestion system is now set up and ready for use! |
| ---------------------------------------------------------- |

---

## Commands

| ℹ Precede all commands covered in the following sections either with your prefix or mention YAGPDB. |
| --------------------------------------------------------------------------------------------------- |

This section documents the commands and subcommands of this system, alongs their use-case and usage.

### For everyone

- `suggest`  
  Syntax: `suggest <Suggestion:Text>`  
  Use: Used to submit a new suggestion.
- `deletesuggestion`  
  Syntax: `deletesuggestion <Suggestion-ID:Whole Number>`  
  Use: Delete the suggestion with the given ID. Can be used by mods to force-delete a suggestion.
- `editsuggestion`  
  Syntax: `editsuggestion <Suggestion-ID:Whole Number> <Edited Suggestion:Text>`  
  Use: Edit the suggestion with the given ID. Replaces the old text entirely with the new text.

### For Mods / Admins

| ℹ All these commands are to be preceded with `sa` or `suggestadmin`. |
| -------------------------------------------------------------------- |

- `deny`  
  Syntax: `deny <Suggestion-ID:Whole Number> [Reason:Text]`  
  Use: Deny a suggestion and notify the author that their suggestion has been deleted, along with the optional reason for denial.
- `dupe`  
  Syntax: `dupe <Suggestion-ID:Whole Number> <Old Suggestion-ID:Whole Number>`  
  Use: Mark the first given suggestion as a dupe of the second suggestion, delete the duplicate and inform the author of the duplicate.
- `approve`  
  Syntax: `approve <Suggestion-ID:Whole Number> [Comment:Text]`  
  Use: Approve a suggestion and log it to the channel for approved suggestions and notify the author. Adds a record of who approved the suggestion.
- `implement`  
  Syntax: `implement <Suggestion-ID:Whole Number> [Comment:Text]`  
  Use: Log a suggestion to the channel for implemented suggestions and notify the author. Sets a record of who implemented this suggestion.
- `comment`  
  Syntax: `comment <Suggestion-ID:Whole Number> <Comment:Text>`  
  Use: Comment on a suggestion. If there is already a comment, this will override the old comment. Can be used on any kind of suggestion.

| ℹ Required arguments are enclosed in `< >`, optional arguments in `[ ]`. |
| ------------------------------------------------------------------------ |

---

## FAQ

**Q: What is a suggestion ID?**
A: This is just the message ID of the suggestion message. If you are unsure how to get message IDs, you can read [this](https://support.discord.com/hc/en-us/articles/206346498) handy Discord article.

**Q: I can't implement an approved suggestion! Why?**
A: This is very likely because you copied the wrong message ID. Double check your input.

**Q: When I try to save, it errors with "response too long". What am I doing wrong?**
A: You need to remove the first two comments, as shown [further up](#what-to-remove).

---

**This custom Report System is developed by [@Satty9361](https://github.com/Satty9361).**
