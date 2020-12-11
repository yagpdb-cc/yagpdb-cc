# YAGPDB-CAH-groups
Make groups of card packs for YAGPDB Cards Against Humanity games!

## Setup
This repo contains a set of custom commands for use with [Yet Another General Purpose Discord Bot (YAGPDB)](https://yagpdb.xyz).

Each command has a corresponding text file. To set up the command system, follow these steps:
- Find the Custom Commands section of the YAGPDB Control Panel (under `Core > Custom Commands` in the left sidebar).
- (Optional but recommended) Create a new custom command group (by clicking the plus icon next to the `Ungrouped` tab). Set the desired permissions for this group of commands.
- Hit `Save group settings`.
- Hit `Create a new Custom Command` (the other big green button at the bottom of the page).
  + Pick a text file from this repository to start with.
  + Choose `Command (mention/cmd prefix)` as the `Trigger type`.
  + Set the command's trigger to the name of the file you just chose (without the `.txt` ending).
  + Paste the contents of the file into the command's `Response` box.
- Repeat the above step for all other text files in this repo.
- Test it out! The commands will provide usage tips if you do something wrong.

## Troubleshooting
Since this is premade code, it should "just work."
However, if things go wrong or don't work at all, try rechecking the permissions (for the group as well as the individual command), or re-paste the code into the `Response` box.
