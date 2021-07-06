---
sidebar_position: 1
title: Overview
---

Custom report system, featuring basic tracking and notifications.

## Installation

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. Additionally, we've documented how and where to add these scripts down below.

Navigate to your [control panel](https://yagpdb.xyz/manage) and select the server you want to add this package to. Make sure you are logged into the right account.  
First off, navigate on your control panel to **Tools & Utilities > Moderation** and select the **General** tab. Find the switch labelled **Enable report command?** and confirm that it is off (it will turn red when that is the case). For a visual reference, take a look at the following screenshot:

### Disabled report command:

![disabled report command](/img/report_system_disabled_report_cmd.png)

Now navigate to **Core > Command settings** and select the **Global** tab. We are going to create a new command override for the report command. Select this command in the dropdown and hit the switch **Enable specified commands?** so that it turns red. You'll find a visual reference as the following screenshot:

### Command override:

![command override](/img/report_system_override.png)

Navigate to **Core > Custom commands**. If you want to keep it all neat and organized, create a new category called "Report System" or similar, just so that you know what kind of commands are in there.  
Copy the code and create for each command in the system a new custom command. Refer to the page corresponding to the command for trigger, trigger type, and any configuration needed.

Navigate back to Discord and run `-ru dbSetup`. Please note that this sub-command is case sensitive. Upon success, YAGPDB will respond with

> Database primed, report numbers reset, system is ready to use!

:::info

Your report-system is now set up!

:::

## Gallery / Various

The following section showcases various notes and screenshots related to this custom command package.

### Default interface

The message each report starts with. No cancellation request, no responsible moderator.

![default message](/img/report_system_default_message.png)

### Pending request

This is how a report looks like when the reporting user requested a cancellation.

![report with cancellation](/img/report_system_pending_cancellation_request.png)

### Notification

The message that gets sent along certain actions.

![example notification](/img/report_system_notification.png)

### Colour

There are several states a report can be in, and each one has an individual colour. This will make it easier for you and your staff to see which report needs the most attention (also everybody likes a little colour):

- ![#808080](/img/color_808080.png) Pending moderator review
- ![#FF00FF](/img/color_ff00ff.png) Pending cancellation request
- ![#FFFF00](/img/color_ffff00.png) Under investigation
- ![#0000FF](/img/color_0000ff.png) Information requested
- ![#00FF00](/img/color_00ff00.png) Report resolved
- ![#FF0000](/img/color_ff0000.png) Cancellation request denied

## Author

This custom command system was written by [@l-zeuch](https://github.com/l-zeuch).
