# Tag
> This command manages the tag system.

# Table of Contents
* [Options](#Options)
	* [Trigger](##Trigger)
* [Description](#Description)
	* [Usage](##Usage)
* [Code](#Code)

# Options
## Trigger
**Trigger Type:** `StartsWith`<br>
**Trigger Value:** `;`;

# Description
This commands allow you to create a simple tag system for your server.

## Usage
`;tag add <name> <value>`
`;tag del <name>`
`;tag addalias <name> <...aliases>`
`;tag delalias <name> <alias>`
`;tag list`
`;tag info <name>`
`;<tag>` (i.e say you have tag with name `foobar`, `;foobar` would view that tag)

# Code
* [Full](./tag.cc.go) | `6,184` characters total<br>
Note that the code is over 6k characters and is only for viewing purposes. Use the minified version when adding instead.

* [Minified](./tag.minified.go) | `4,572` characters total
