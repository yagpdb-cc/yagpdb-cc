# Birthdays
This custom command adds a birthday functionality to your server, wishing members all the best on their respective date.

## Features
* Send a congratulation message in the chat
* Kick or Ban users younger than 13 years
* Allow users to set their birthday date
* Allow staff to edit/remove birthday dates

## Installing
As usual, there are leading comments in each file describing where to put the script and which trigger to use. 
Additionally, we've documented how and where to add this script down below.

If you instead want to update to v2, because you used an older version, please click [here](#Updating).

| ⚠ To be able to add custom commands, you need control panel write access. |
| ---- |

Add the only command, [birthday.go.tmpl](birthday.go.tmpl) as a new custom command. The trigger is going to be a RegEx trigger as follows.

###### Birthday CC trigger
```
\A\-(my|start|stop|set|get|del)b(irth)?days?
```
| ℹ Make sure to replace `-` with your server's prefix. |
| ---- |

Save for now and take your time reading through the following section describing the configuration variables.