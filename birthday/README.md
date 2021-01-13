Birthday CC V2.0
================

# Info

| ℹ If you used V1.0 of this command, read `UPDATING FROM V1.0` at the bottom of this doc before updating. |
| --- |
<p>
This command will send a congratulation message to the users of your server on their birthday.<p>
This code can kick/ban users if they are under 13 years old, if you want it to.<p>
Change <b>ONLY</b> the user variables.<p>
User can only set their birthday once. After that a mod will have to set a new one or delete the existing one.<p>

# Trigger

## Trigger Type -  Regex

## Trigger - 
   `\A-(my|start|stop|set|get|del)b(irth)?days?`
| ⚠ If your prefix is not `-` replace the `-` at the start of the trigger with your prefix. |
| --- |

# Variables

1. `$mods` -

   Is the list of the Roles IDs that should be able to use all commands.

2. `$ChannelID` -

   Is the ID of the channel where the congratulations messages will be sent.

3. `$bdayMsg` -

   Is the message that will be sent to congratulate users on their birthdays.

4. `$invertedOrder` -

   If set to `true`, the date syntax will be `mm/dd/yyyy`.<p>
   If set to `false`, the date syntax will be `dd/mm/yyy`.

5. `$yearOptional` -

   If set to `true`, it makes the year optional. The default year is 2000 when this variable is true.

6. `$kickUnderAge`

   If set to `true`, the bot will kick users that are under 13 years-old.

7. `$banUnderAge`

   If set to `true`, the bot will ban users that are under 13 years-old.

# Commands

All commands can be used with bday or birthday. Example: -getbday or -getbirthday<p>

1. **mybirthday 20/12/1998**
   1. Will set the user birthday to be that date and the bot will congratulate them on that day.<p>
      Note: syntax is `day/month/year` if you want it to be `month/day/year` set `$invertedOrder` to `true`.
1. **startbdays**
   1. Use this command at the time you want the bot to send the birthday msgs.<p>
      Example: if you use this at 1PM in your local time, the congratulations messages will always be sent at 1PM everyday.<p>
      Optional duration flag: -startbdays 1h12m<p>
      Using the command like that would make the bday msg be sent everyday at 1h and 12 minutes after this command was triggered.
1. **stopbdays**
   1. This will stop the bdays msgs from being sent.<p>
1. **setbday**
   1. This will set a targeted user birthday.<p>
      Example: -setbday 20/12/1998 @Pedro
1. **getbday**
   1. This will tell you the birthday of the specified user.<p>
      Example: -getbday @Pedro
1. **delbday**
   1. This will delete the targeted user birthday. If no user is targeted, it will delete the triggering user bday.

## UPDATING FROM V1.0

I found out that there were a few bugs on this code since I last updated it.<p>
I **highly** recommend you update your code with this newest version, since all these bugs have been fixed. <p>
But, one of these bugs were that some users were being congratulated more than once.<p>
If this is happening on your server, you can run this CC and wait for the bot to send `All set, you can now use V2.0`.<p>
After that you can update to V2.0.<p>
If you were not experiencing this issue, you don't need to run this CC.<p>
| ⚠ This will erase **ALL** birthdays you currently have stored on your server. Users will have to set them up again. |
| --- |

Code:
```
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
      Still running deletation...
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
   Wait... Deletation is being done.
   {{execCC .CCID nil 1 "1"}}
{{end}}
```