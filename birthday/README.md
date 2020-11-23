# Birthday CC

## Info

All commands can be used with bday or birthday. Example: -getbday or -getbirthday<p>
This code will also kick/ban users if they are under 13 years old, if you want it to.<p>
Change ONLY the user variables<p>
$mods is the list of the Roles IDs that should be able to use all commands.<p>
User can only set their birthday once. After that a mod will have to set a new one or delete the existing one.<p>
Trigger Type: regex<p>
Trigger: \A-(my|start|stop|set|get|del)b(irth)?days?

## Commands

1. **-mybirthday 20/12/1998**
   1. Will set the user birthday to be that date and the bot will congratulate them on that day<p>
      Note: syntax is day/month/year if you want it to be month/day/year set $invertedOrder to true
1. **-startbdays**
   1. Use this command at the time you want the bot to send the birthday msgs<p>
      Example: if you use this at 1PM in your local time, the congratulations messages will always be sent at 1PM everyday<p>
      Optional duration flag: -startbdays 1h12m<p>
      Using the command like that would make the bday msg be sent everyday at 1h and 12 minutes after this command was triggered
1. **-stopbdays**
   1. This will stop the bdays msgs from being sent<p>
1. **-setbday**
   1. This will set a targeted user birthday<p>
      Example: -setbday 20/12/1998 @Pedro
1. **-getbday**
   1. This will tell you the birthday of the specified user<p>
      Example: -getbday @Pedro
1. **-delbday**
   1. This will delete the target user birthday, if no user is target, it will delete the triggering user bday.
