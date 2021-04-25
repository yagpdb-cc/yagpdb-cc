# Birthdays
This custom command adds birthday functionality to your server, wishing members all the best on their respective date.

## Features
* Send a configurable message in the chat on birthdays
* Configure to kick or ban users younger than 13 years
* Allow users to set their birthday 
* Allow staff to edit/remove birthdays

## Installing
As this script does not have any leading comment, we've documented everything down below.

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
    The channel that birthday messages should be sent in.
- `$bdayMsg`<br>
    The message sent on a member's birthday.
- `$invertedOrder`<br>
    Date format to use. If set to to `true`, YAGPDB will use the american notation `mm/dd/yyyy` instead of `dd/mm/yyyy`.
- `$yearOptional`<br>
    Whether the year is optional when configuring birthdays; set to `true` to enable. This will make the year default to `2000`, should a member not give a year upon configuring their birthday.
- `$kickUnderAge`<br>
    Whether to kick users younger than 13 years old; set to `true` to enable.
- `$banUnderAge`<br>
    Same as above, but will instead ban users younger than 13 years old, will take priority over `$kickUnderAge`.

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
    Use: Get the birthday of the mentioned user, can only be used by users with at least one role in `$mods`.
- `delbirthday`<br>
    Syntax: `delbirthday <User:Metion>`<br>
    Use: Delete the set birthday of the mentioned user. Can only be used by users with at least one role in `$mods`.

After you've configured all those variables, save again.
| ✅ Your birthday system is now ready to use! |
| ---- |

# Updating
As the first version had some flaws, such as congratulating a member more than once, we highly recommend updating to v2. To do that, please follow the steps below.

| 🛑 This will erase all set birthdays. Your members will have to set them up again. |
| ---- |

Add this script as a new custom command with any trigger you like, such as a command trigger with `update`. After that, just run it.

Once that is done, YAGPDB will respond with `All set, you can now use V2.0`.
| ✅ You may now install the latest version as described above. |
| ---- |

```go
{{with .ExecData}}
   {{if eq . "1"}}
      {{range seq 0 10}}
         {{dbDel . "bdays"}}
      {{end}}
      {{execCC $.CCID nil 2 "2"}}
   {{else if eq . "2"}}
      {{range seq 9 13}}
         {{dbDel . "bdays"}}
      {{end}}
      {{execCC $.CCID nil 3 "3"}}
   {{else if eq . "3"}}
      Deletion is still in progress.
      {{$day := currentTime.Day}}
      {{range seq (sub $day 3) (add $day 3)}}
         {{dbDel . "bdayannounced"}}
      {{end}}
      {{execCC $.CCID nil 4 "4"}}
   {{else if eq . "4"}}
      {{$entries := dbTopEntries "bday" 9 0}}
      {{if not $entries}}
         All set, you can now use V2.0
      {{else}}
         {{range $entries}}
            {{dbDel .UserID "bday"}}
         {{end}}
         {{if le (len $entries) 9}}
            All set, you can now use V2.0
         {{else}}
            {{execCC $.CCID nil 5 "5"}}
         {{end}}
      {{end}}
   {{else}}
      {{$entries := dbTopEntries "bday" 9 0}}
      {{if not $entries}}
         All set, you can now use V2.0
      {{else}}
         {{range $entries}}
            {{dbDel .UserID "bday"}}
         {{end}}
         {{execCC $.CCID nil 5 "5"}}
      {{end}}
   {{end}}
{{else}}
   Please wait... Deletion is in progress.
   {{execCC .CCID nil 1 "1"}}
{{end}}
```

---- 
This custom command was authored by [@Pedro-Pessoa](https://github.com/Pedro-Pessoa).
