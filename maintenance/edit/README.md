# edit
> Edit messages sent by YAGPDB

# Table of Contents
* [Options](#Options)
	* [Trigger](##Trigger)
	* [Restrictions](##Restrictions)
* [Description](#Description)
	* [Usage](##Usage)
* [Code](#Code)

# Options
## Trigger
**Trigger Type:** Command<br>
**Trigger Value:** `edit`<br>


## Restrictions
* Should be restricted to channel X
* Should be restricted to role Y


# Description
This command is a tool for editing messages sent by YAGPDB.
	Flags:  -content : To Change Content
		-title, -desc, -image, -thumbnail, -url, -author, -authoricon, -authorurl, -footer, -footericon, -color : To Edit Embed
		-force : Makes a new embed with provided fields and discards previous embed (default behavior is simply editing provided fields of embed while preserving other fields)
		-clrembed : To remove the embed from a message previously containing embed (so that now it has only content. Note, You cant remove embed if content is also null)

## Usage
`-edit [channel] <msg> <flags...>`

# Code
* [Full](./edit/edit.cc.go) | 6389 characters total<br>
Note that the code is over 6k characters and is only for viewing purposes. Use the minified version when adding instead.

* [Minified](./edit.minified.go) | 4035 characters total<br>
