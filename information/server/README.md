# server
> View information about the server

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
**Trigger Value:** `\A-(server|guild)(-?info)?`<br>


## Restrictions
* Should be restricted to channel X
* Should be restricted to role Y


# Description
This command allows you to view information about the server.

## Usage
`-serverinfo` (Use `-server icon` to view the server icon)

# Code
* [Full](./server/server.cc.go) | 2361 characters total<br>

* [Minified](./server.minified.go) | 1855 characters total<br>