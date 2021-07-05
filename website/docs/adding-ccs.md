---
sidebar_position: 2
title: Adding Custom Commands
---

This assumes you know how to create a custom command. If you aren't too familiar with that or just need a refresher, [this article](https://learn.yagpdb.xyz/the-custom-command-interface) explains it well.

The **yagpdb-cc** repository is separated into groups / categories. Most categories have standalone custom commands, meaning you can add one, two, or even all of them without issues. There are, however, some "systems" which require you to add all commands in that section. This is detailed in the individual `Read Me`s of that section.

When you find a custom command you wish to add, the file will have a **leading comment** explaining what it does and the recommended trigger type & trigger value. You can add it in the YAGPDB dashboard with these attributes.

### Leading Comments

As explained above, each custom command will have a leading comment. An example of this is as follows:

```go
{{/*
	This command shows all the avaliable properties and methods of a structure with a link to the Discord docs on that structure.
	Usage: `-struct <struct>`.

	Recommended trigger: Regex trigger with trigger `\A(-|<@!?204255221017214977>\s*)(struct)(ure)?(\s+|\z)`
*/}}
```

This comment explains what the custom command does, the usage, and the recommended trigger type and trigger.

:::caution
Make sure to remove the **\` \`** at the start and end of the trigger.  
The back ticks are not part of the trigger itself, but rather, are stuctured to help identify the start and end of the trigger.
:::

Some systems have a note stating that you must remove the leading comment due to the custom command being too long.  
For example:

```go
{{/*
        Main Giveaway CC. Supports execCC invoke. Usage: Read README.md

        Recommended Trigger: Command trigger with trigger `giveaway`
        (Can also work with `regex` and `starts with` triggers if triggers are correctly set)

        Note: Command is very long so you MUST remove this comment and the next one after it for it to save properly.

{{/*CONFIGURATION VALUES START*/}}
*/}}
```

Follow the instructions as it states. Remove the leading comment, and further comments to remove if it says to do so.

### Configuration Variables

In many custom commands there will be a `{{/* CONFIGURATION AREA STARTS */}}` where you must edit the values of the variables for the command to properly work in your server. The variables between `{{/* CONFIGURATION AREA STARTS */}}` and `{{/* CONFIGURATION AREA ENDS */}}` are what you must edit to run the custom command properly.

Please do not edit the code, unless you _really_ know what you are doing.

In a few systems, partucularly [Starboard V2](fun/starboard/overview), there are multiple custom commands in the system that need identical values for the configuration variables to allow the system to work as intended. This will be stated as a reminder in the system's `Read Me` or the leading comment.
