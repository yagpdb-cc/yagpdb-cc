x# role-rewards
> Manages the role rewards of the server

# Table of Contents
* [Options](#Options)
	* [Trigger](##Trigger)
	* [Restrictions](##Restrictions)
* [Description](#Description)
	* [Usage](##Usage)
* [Code](#Code)

# Options
## Trigger
**Trigger Type:** Regex<br>
**Trigger Value:** `A-(role-?rewards|rr)`<br>


## Restrictions
* Should be restricted to channel X
* Should be restricted to role Y


# Description
This command manages the role rewards of the server for the leveling system
Types of role giving:
	- stack: Users get all roles up to current level [DEFAULT]
	- highest: Users get the last role reward closet to current level [MAY BE BUGGY]

## Usage
	-rr add <level> <role name> | Adds a role reward to given level in range 1-100. Max 1 per level.
	-rr remove <level> | Removes role reward from level.
	-rr set-type <stack|highest> | Sets type of role giving.
	-rr view | Views current setup
	-rr reset | Resets the settings

# Code
* [Full](./role-rewards/role-rewards.cc.go) | 5037
 characters total<br>
Note that the code is over 5k characters and is only for viewing purposes. Use the minified version when adding instead.

* [Minified](./role-rewards.minified.go) | 2958
 characters total<br>