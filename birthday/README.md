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

Save for now, so it doesn't get lost.

## Configuration
Before your birthday custom command is ready to go, you still need to configure a few things. Please read carefully through their decription before changing anything.

- `$mods`<br>
    List of role IDs you consider moderator. Separate multiple role IDs by spaces.
- `$ChannelID`<br>
    Configures where the birthday messages are being sent to.
- `§bdayMsg`<br>
    This variable defines the message that'll be sent on a member's birthday.
- `$invertedOrder`<br>
    Configure which date format will be used. If set to to `true`, YAGPDB will use the american notation `mm/dd/yyyy` instead of `dd/mm/yyyy`.
- `$yearOptional`<br>
    Set this to `true` to make the year optional. This will make it default to `2000`, should a member not give a year upon configuring their birthday.
- `$kickUnderAge`<br>
    If `true`, YAGPDB will kick users younger than 13 years.
- `$banUnderAge`<br>
    Same as above, but instead will ban users younger than 13 years.

## Commands
| ℹ All commands can be used with `bday` or `birthday`, such as `-getbday` or `-getbirthday`. |
| ---- |

- `mybirthday`<br>
    Syntax: `mybirthday dd/mm/yyyy` or `mybirthday mm/dd/yyyy`<br>
    Use: Set your birthday to the given date. Note that if `$invertedOrder` is true, you'd have to use the latter version, as it now uses american date notation.
- `startbirthday`<br>
    Syntax: `starbirthday [Duration:Duration]`<br>
    Use: Start announcing birthdays at the time of executing this command. Provide an optional duration to fine-tune the timing.
- `stopbirthday`<br>
    Syntax: `stopbirthday`<br>
    Use: Stops announcing birthdays immediately.
- `setbirthday`<br>
    Syntax: `setbirthday <User:Mention>`<br>
    Use: Set the birthday date of the mentioned user. Can only be used by users with at least one role in `$mods`.
- `getbirthday`<br>
    Syntax: `getbirthday <User:Mention>`<br>
    Use: Get the birthday of the mentioned user.
- `delbirthday`<br>
    Syntax: `delbirthday <User:Metion>`<br>
    Use: Delete the set birthday of the mentioned user. Can only be used by users with at least one role in `$mods`.

