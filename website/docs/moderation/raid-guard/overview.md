---
title: Overview
---

A simple raid monitoring system.
It keeps track of new members, and when too many join at a time staff are alerted and have the ability to run a moderation action on all the new members at once.

## About

This code was created in response to a raid that was done on a server that I am an admin. Over 100 people raided the server, and started sending messages and DMing people. It took staff members at least 30 minutes to realize that all these people were from all one raid, as we hadn't been pinged, or notified. That's when I came up with this idea of a monitoring system. This system will oversee all incoming members, if that member has an account that is younger than a certain age (1 day default), then they will be added to a database list. If that list reaches a certain amount of people (25 users by default) within 10 minutes, then it will send a notification to the mod-log.

This notification will alert the administrators (or a role of your choosing), and ask if they would like to kick/ban all of the members part of the raid at once. An option has also been provided to manually reset the raid list. The program will run through the entire list and remove all raiders for good.

## Installation

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. There are two commands in this system, both of which must be added for it to work as expected:

- [Raid admin](raid-admin)
- [Join trigger](join-trigger)

As the setup for this system is not too complicated, we'll leave it at that. Please refer to the instructions in the pages linked above if you have any other questions.

## Author

This custom command system was written by [@ENGINEER15](https://github.com/engineer152/).
