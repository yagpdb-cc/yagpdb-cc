# Raid Guard System

A simple Raid monitoring system, with admin moderation commands.

## About

This code was created in response to a raid that was done on a server that I am an admin. Over 100 people raided the server, 
and started sending messages, DMing people. It took us admins at least 30 min to realized that all these people were from all 
one raid, as we hadn't been pinged, or notified. That's when I came up with this idea of a monitoring system. This system will 
oversee all incoming members, if that member has an account that is younger than a certain age (1 day default), then they will 
be added to a database list. If that list reaches a certain amount of people (25 ppl default) within 10 min, then it will send a 
notification to the modlog.

This notification will alert the admin (or a role of your choosing), and ask if they would like to 
kick/ban all of the RAID members at once. An option has also been provided to manually reset the raid list. The program will run 
through the entire list and remove all raiders for good.

## Commands Available:

All commands are preceeded by: `-raid <action>`

## Actions:

`kick` - Kick all members within raid list.

`ban` - Ban all members within raid list.

`clear` - Clear the raid list of all members.
