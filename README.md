#

<h1 align="center"><img src="https://yagpdb.xyz/static/img/logo_y.png" height=32px width=32px></img>&nbspYAGPDB Custom Commands</h1>

> <p align="center">An up-to-date collection of CCs for your server</p>

<p align="center">
	<i>
		Check out our <a href="https://yagpdb-cc.github.io">new website</a>, which displays all custom commands available here in addition to instructions on how to add them!
	</i>
</p>

# Table of Contents

- [Adding these Custom Commands](#adding-these-custom-commands)
- [Custom commands available](#custom-commands-available)
- [Contributing](#contributing)
- [Disclaimer](#disclaimer)
- [Need help?](#need-help)
- [Contributors](#contributors)

## Adding these custom commands

This assumes you know how to create a custom command, if you aren't too familiar with that or just need a refresher, [this article](https://learn.yagpdb.xyz/the-custom-command-interface) explains it well.

The **yagpdb-cc** repository is separated into groups / categories. Most categories have standalone custom commands, meaning you can add one, two, or even all of them without issues. There are, however, some "systems" which require you to add all commands in that section. This is detailed in the individual `README.md` of that section.

When you find a custom command you wish to add, the file will have a leading comment explaining what it does and the recommended trigger type & trigger value. You can add it in the YAGPDB dashboard with these attributes.

## Custom commands available

<details>
<summary>List of Custom Commands</summary>

- [AFK system](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/afk)
  - Set AFK with optional duration and message
  - When pinged, shows AFK message and duration if avaliable
- [Fun commands](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/fun)
  - Deathmatch / battle others
  - Starboard
  - Random animals
  - And more!
- [Giveaway system](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/giveaway)
  - Create giveaways with time, prize, max number of partcipants, and amount of winners
  - End giveaways
  - Cancel giveaways
  - List giveaways
  - Execute within CCs with execCC
- [Info commands](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/info)
  - Server info
  - Channel info
  - User info
  - Avatar CC
- [Leveling system](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/leveling)
  - Create/view/edit role rewards which are given on levelup
  - View leaderboard
  - Give variable amount of XP with variable cooldowns on messages
  - View user profiles
  - And others!
- [Useful snippets](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/snippets) for your own custom commands
  - Selection sort (sort an array ASC-DESC)
  - Convert string to time
  - Find closest number from provided number in cslice
- [Suggestion system](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/suggestion)
  - Create suggestions
  - Comment, approve, or deny them
  - Edit and remove them
- [Tag system](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/tag)
  - Create tags with aliases
  - Edit tags
  - Delete tags
  - View tags simply with `;(tag name)`
- [General utility commands](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/util) + Preview colors + See time and weather in your location + World clock + Big emoji
</details>

_This is by no means an exhaustive list, nor is it meant to be. See the individual folders for details._

## Contributing

If you spot an error, feel free to make a PR or open an issue.
If you wish to add your own command, feel free to make a PR as well. Note that not all CCs PRed will be added; merging is up to maintainers. Don't take it personally if your PR didn't make it through - we only accept custom commands that we feel will be useful to many people.

_If you are adding a new CC, please read the [guidelines](./CONTRIBUTING.md). We don't have too many hard-and-fast conventions in place other than some about documentation_.

## Disclaimer

The YAGPDB developer, staff, and/or support are not responsible for any difficulties caused by these custom commands.
These commands are not guaranteed to be working, use them at your own risk.

## Need help?

If you are having difficulties with one of the custom commands here, please get in touch via the [YAGPDB Support Server](https://discord.gg/5uVyq2E), where we can help you further. You can also open an issue on the issue tracker if that's what you prefer.

## Contributors

**yagpdb-cc** is currently maintained by [@jo3-l](https://github.com/jo3-l), [@Satty9361](https://github.com/Satty9361), [@l-zeuch](https://github.com/l-zeuch), [@Pedro-Pessoa](https://github.com/Pedro-Pessoa) and [@DaviiD1337](https://github.com/DaviiD1337).<br>
It is licensed under the MIT License.

We would also like to acknowledge the many contributors, seen below. Thank you!

<a href="https://github.com/yagpdb-cc/yagpdb-cc/graphs/contributors">
<img src="https://contributors-img.web.app/image?repo=yagpdb-cc/yagpdb-cc" />
</a>
