# Tag
> This command manages tag list pagination.

# Table of Contents
* [Options](#Options)
	* [Trigger](##Trigger)
* [Description](#Description)
* [Code](#Code)

# Options
## Trigger
**Trigger Type:** `Reaction trigger`<br>
**Trigger Value:** `REACTION ADDED only`;

# Description
This reaction listener is used to move through the pages for the tag command

## Usage
`;tag add <name> <value>`
`;tag del <name>`
`;tag addalias <name> <...aliases>`
`;tag delalias <name> <alias>`
`;tag list`
`;tag info <name>`
`;<tag>` (i.e say you have tag with name `foobar`, `;foobar` would view that tag)

# Code
* [Full](./reactionListener.cc.go) | `1,267` characters total<br>
Note that the code is over 1k characters and is only for viewing purposes. Use the minified version when adding instead.

* [Minified](./reactionListener.minified.go) | `4,572` characters total
