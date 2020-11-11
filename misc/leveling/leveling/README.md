# leveling
> Manage the general level settings of the guild

# Table of Contents
* [Options](#Options)
	* [Trigger](##Trigger)
* [Description](#Description)
	* [Usage](##Usage)
* [Code](#Code)

# Options
## Trigger
**Trigger Type:** Regex<br>
**Trigger Value:** `A-(leveling|(level|lvl)-?conf|(level|lvl)-?settings)`<br>


# Description
This command manages the general level settings of the guild for the leveling system

## Usage
-leveling set <key> value | example: -leveling set cooldown 1 minute 30 seconds 
-leveling use-default | use default settings 
-leveling view | view settings

# Code
* [Full](./leveling/leveling.cc.go) | 4424
 characters total<br>
Note that the code is over 4k characters and is only for viewing purposes. Use the minified version when adding instead.

* [Minified](./leveling.minified.go) | 2620
 characters total<br>