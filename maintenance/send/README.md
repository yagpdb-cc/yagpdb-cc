# send
> Send messages through YAGPDB

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
**Trigger Value:** `^-(send-?(raw)?)`<br>


## Restrictions
* Should be restricted to channel X
* Should be restricted to role Y


# Description
This command allows you to send messages through YAGPDB, with optional channel. You may send it as embed using `-send [channel] <content>` or as raw with `-send-raw [channel] <content>`.

## Usage
`-send [channel] <content>` or `-send-raw [channel] <content>`

# Code
* [Full](./send/send.cc.go) | 1221
 characters total<br>
Note that the code is over 10k characters and is only for viewing purposes. Use the minified version when adding instead.

* [Minified](./send.minified.go) | 746
 characters total<br>