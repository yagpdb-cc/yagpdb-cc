---
sidebar_position: 1
title: YAGPDB CAH Groups
sidebar_label: CAH Read Me
---

Make groups of card packs for YAGPDB Cards Against Humanity games!

---

## Setup
This folder contains a set of custom commands for use with YAGPD.

Each command has a corresponding text file. To set up the command system, follow these steps:
- Find the Custom Commands section of the YAGPDB Control Panel (under `Core > Custom Commands` in the left sidebar).  
- (Optional but recommended) Create a new custom command group (by clicking the plus icon next to the `Ungrouped` tab). Set the desired permissions for this group of commands.
- Hit `Save group settings`.
- To add a new command:
    - Hit `Create a new Custom Command` (the other big green button at the bottom of the page).
    - Pick a file from this repository to start with.
    - Choose `Command (mention/cmd prefix)` as the `Trigger type`.
    - Set the command's trigger to the name of the command you just chose.
    - Paste the contents of the file into the command's `Response` box.
    - Some commands have configuration variables that you'll need to change. These will be near the top of the command, right after the description block.
- Repeat the above step for all other files in this repo (except this one, of course).
- Test it out! Some of the commands will provide usage tips if you do something wrong.

---

## Troubleshooting
Since this is premade code, it should "just work." However, if things go wrong or don't work at all, try rechecking the permissions (for the group as well as the individual command), or re-paste the code into the `Response` box. If all else fails, contact us in the YAGPDB [support server](https://discord.com/invite/4udtcA5)!

---

This custom command was authored by [@LRitzdorf](https://github.com/LRitzdorf).