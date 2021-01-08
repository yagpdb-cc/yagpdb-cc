# Report System
These commands are **not** standalone. Add all the commands if you wish to use them.

These CCs allow you to create a report system with the ability for users to request cancellation/nullification of their reports and add some functionalities for staff utilizing reactions.
All neccessary information is arranged in an embed which is edited accordingly.

Should you need further information because something is unclear, or want to report a bug, feel free to open an issue, or follow the invite on [my profile](https://github.com/Olde7325).

# Table of Contents
<details>
<summary>Table of Contents</summary>

* [Features](#Features)
* [Setting Up](#Setting-Up)
* [Usage](#Usage)
    * [Interface](#Interface)
        * [Reaction Menu](#Reaction-Menu)
        * [Colour Coding](#Colour-Coding)
        * [Default Reaction Inferface](#Default-Reaction-Inferface)
        * [Pending Cancellation Request](#Pending-Cancellation-Request)
        * [Notification Message](#Notification-Message)
* [Acknowledgements](#Acknowledgements)
* [Planned Features](#Planned-Features)
* [Author](#Author)
</details>

# Features
* Logging Channel for report messages
* Cancellation requests
* Report history
* Reaction Menu
* Notifications

# Setting Up
| ⚠ You need `Manage_Server` permission in order to run the setup command! |
| --- |

Make for each custom command file a separate custom command, preferrably in the same category to keep them neat and organized. Please make sure to follow each step precisely and to use the correct trigger and trigger type, as well.

#### Here's what you have to do:
1. Disable the native report command, found here: `Control Panel > Tools & Utilities > Moderation`, like [this](https://cdn.discordapp.com/attachments/767771719720632350/795330583303028746/unknown.png)
2. Configure the variables in [the main command](customReport.go.tmpl) as described there.
4. Run the **case sensitive** command `-ru dbSetup`
5. Done! YAGPDB.xyz will now take care of the rest and confirms setting up with an appropiate response.  

---
| 🛑 Pay attention to the trigger types and triggers! |
| --- |

For [the main command](customReport.go.tmpl) it is a RegEx trigger type with the trigger `\A-r(eport)?(?:u(ser)?)?(\s+|\z)`.  
[The second command](cancelReport.go.tmpl) requires a RegEx trigger as well, with the trigger being `\A-c(ancel)?r(eport)?(\s+|\z)`.
The [reaction handler](reactionHandler.go.tmpl) needs a Reaction trigger with "Added reactions only" selected.

| ℹ Make sure to change `-` in both RegEx triggers to match YAGPDB's prefix in your server!<br/>It is also recommended to create a [command override](https://cdn.discordapp.com/attachments/767771719720632350/795328377158369330/unknown.png) disabling the `report` command completely. |
| --- |

# Usage
## Commands
`-ru <User:Mention/ID> <Reason:Text>` - Sends the report. 

`-cr <MessageID:Text> <Key:Text> <Reason:Text>` - Requests cancellation of the latest report. The key is given to the reporting user in a custom command DM.

## Interface
| ℹ Only members with `Manage_Messages` permission will be able to use the reaction menu. |
| --- |

### Reaction Menu
The bottom-most field in the embed will give you a short explanation on what the buttons do.
Please take some time to read the intention behind a few options:

**Dismissing a report:** Some call it "ignoring". Both is fine. Basically it tells the reporting user that their report has no ground to stand upon on.
**Requesting information:** You can see it as a step before ignoring, in case the reported user is a known case, but the report reason is not a very substantive one.  
**Starting investigation:** This one should be obvious. Looking into it, reading the logs, discussing with other staff, talking with the reported user, finding a solution.  
**Resolving a report:** Used when the reported user was punished accordingly or the report turns out to be for a bagatelle.

Of course, there are more options than just these four, however the missing ones are a fair bit clearer than these.

| ✅ Once a report is closed, YAGPDB.xyz will add a white flag (🏳️) as reaction to signalize a closed report. |
| --- |

### Colour Coding
Each state has its own colour, for one to make it easier on the eyes and also to make it easier for you and your staff team recognizing in what state each report is.

* ![#808080](https://cdn.discordapp.com/attachments/767771719720632350/793546124903317554/000000.png) Pending moderator review
* ![#FF00FF](https://cdn.discordapp.com/attachments/767771719720632350/793546157316898857/000000.png) Pending cancellation request 
* ![#FFFF00](https://cdn.discordapp.com/attachments/767771719720632350/793546178070446140/000000.png) Under investigation 
* ![#0000FF](https://cdn.discordapp.com/attachments/767771719720632350/793546199532699678/000000.png) Information requested
* ![#00FF00](https://cdn.discordapp.com/attachments/767771719720632350/793546218068115486/000000.png) Report resolved 
* ![#FF0000](https://cdn.discordapp.com/attachments/767771719720632350/793546237483024394/000000.png) Cancellation request denied


### Default Reaction Inferface
![Default Interface Image](https://cdn.discordapp.com/attachments/767771719720632350/787880054238740530/unknown.png)

### Pending Cancellation Request
![Cancellation Inferface Image](https://cdn.discordapp.com/attachments/767771719720632350/787880387141304350/unknown.png)

***Note:*** Upon the first report(s) there will not be any report history. The images are purely meant as examples and do not necessarily represent the reality.

### Notification Message
![Notification Example](https://cdn.discordapp.com/attachments/767771719720632350/793107470993588254/unknown.png)

# Acknowledgements
I also want to thank [Devonte](https://github.com/NaruDevnote), known on Discord as `Devonte#0745`, for helping me developing and fine-tuning this custom command set.

# Planned Features
| ℹ These features are planned and still under development. To request new features, please follow the link on my profile. |
| --- |

- [ ] Custom message in notification.
- [ ] Moderation menu to execute on the reported user for super-duper quick access.

# Author
This Custom-Command package was created by [Olde7325](https://github.com/Olde7325).
The author does not take any responsibilty for bugs and other issues caused by altered code beyond the intended configuaration as described [further up](#Setting-Up).
