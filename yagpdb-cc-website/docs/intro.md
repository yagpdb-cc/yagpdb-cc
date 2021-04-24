---
sidebar_position: 1
slug: /
title: YAGPDB Custom Commands
sidebar_label: YAGPDB CCs
---

---

## Adding These Custom Commands

This assumes you know how to create a custom command, if you aren't too familiar with that or just need a refresher, this [article](https://learn.yagpdb.xyz/the-custom-command-interface) explains it well.

The **yagpdb-cc** repository is separated into groups / categories. Most categories have standalone custom commands, meaning you can add one, two, or even all of them without issues. There are, however, some "systems" which require you to add all commands in that section. This is detailed in the individual `README`s of that section.

When you find a custom command you wish to add, the file will have a leading comment explaining what it does and the recommended trigger type & trigger value. You can add it in the YAGPDB dashboard with these attributes.

---

## Custom Commands Available

<details>
<summary>List of Custom Commands</summary>

- AFK system  
    - Set AFK with optional duration and message  
    - When pinged, shows AFK message and duration if avaliable

- Fun commands
    - Deathmatch / battle others
    - Starboard
    - Random animals
    - And more!

- Giveaway system
    - Create giveaways with time, prize, max number of partcipants, and amount of winners
    - End giveaways
    - Cancel giveaways
    - List giveaways
    - Execute within CCs with execCC

- Info commands
    - Server info
    - Channel info
    - User info
    - Avatar CC

- Leveling system
    - Create/view/edit role rewards which are given on levelup
    - View leaderboard
    - Give variable amount of XP with variable cooldowns on messages
    - View user profiles
    - And others!

- Useful snippets for your own custom commands
    - Selection sort (sort an array ASC-DESC)
    - Convert string to time
    - Find closest number from provided number in cslice

- Suggestion system
    - Create suggestions
    - Comment, approve, or deny them
    - Edit and remove them

- General utility commands + Preview colors + See time and weather in your location + World clock + Big emoji

</details>

---

## Contributing
If you spot an error, feel free to make a PR or open an issue. If you wish to add your own command, feel free to make a PR as well. Note that not all CCs PRed will be added; merging is up to maintainers. Don't take it personally if your PR didn't make it through - we only accept custom commands that we feel will be useful to many people.

*If you are adding a new CC, please read the [guidelines](https://github.com/yagpdb-cc/yagpdb-cc/blob/master/CONTRIBUTING.md). We don't have too many hard-and-fast conventions in place other than some about documentation.*

---

## Need help?
If you are having difficulties with one of the custom commands here, please get in touch via the [YAGPDB Support Server](https://discord.com/invite/5uVyq2E), where we can help you further. You can also open an issue on the issue tracker if that's what you prefer.

---

## Contributors
**[yagpdb-cc](https://github.com/yagpdb-cc/yagpdb-cc)**, and this website is currently maintained by [@jo3-l](https://github.com/jo3-l), [@Satty9361](https://github.com/Satty9361), [@l-zeuch](https://github.com/l-zeuch), [@Pedro-Pessoa](https://github.com/Pedro-Pessoa), and [@DaviiD1337](https://github.com/DaviiD1337).  

It is licensed under the MIT License.

We would also like to acknowledge the many contributors that can be acknowledged [here](https://github.com/yagpdb-cc/yagpdb-cc/graphs/contributors). Thank you!