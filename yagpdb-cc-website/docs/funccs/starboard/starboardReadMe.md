---
sidebar_position: 1
title: Starboard V2
sidebar_label: Starboard Read Me
---

This is version 2 of the starboard custom command. This package now consists of two custom commands, and a more elaborate setup is required. All features of the first version are also found in here.

---

## Features
All the starboard v1 features, plus the following:
- Posts automatically removed when they fall below set star threshold or when number of anti-stars has been reached.
- Ability to ignore stars/ant-stars on old posts (server customizable).
- Anti-star feature similar to an upvote/downvote system with customizable threshold for 'downvotes' before autodeleting (server customizable).
- Ability to react directly on posts in your #starboard channel with either star or anti-star.
    - Accurate tracking between original post and starboard post.
    - Users are unable to duplicate stars/anti-stars between channels.
- Reactions from the original message poster can be ignored (server customizable).
- Message warnings for attempts to duplicate stars/anti-stars and self stars (server customizable).

**NOTE:** *Not all of these features will work on starboard messages created with the original starboard cc*

---

## Installing
1. Add both custom commands to your server with trigger `Reaction - Added + Removed reactions`.
2. [Starboard](starboard) **MUST** be set to **IGNORE** your starboard channel.
3. [starboardListener](starboardListener) **MUST** be set to work **ONLY** in your starboard channel.
4. **User configured variables MUST be the same between both commands**. If you change something on one be sure to change it on the other.
    - Don't forget to configure your starboard channel ID and desired emojis for basic functions to work.

You should not enable anti-stars if your community cannot be trusted to self moderate starboard posts. It should work great for some servers, but could be a total disaster for others. Use your own best judgement regarding your community members.

---

## FAQ

#### Why did I make this?
Starboards on Discord hold a special place in my heart and I wanted one with, what I perceive to be, the most important and valuable features. Every bot with a starboard seems to lack one feature or the other, never all of them. This is what I think is a complete starboard.

#### Why is there no star leaderboard?
Personally, I don't like it. A starboard should be for funny or out of context comments, self-made memes, or similar. Having a leaderboard seems to encourage members to make low-effort, spammy, attention-seeking, or a combination of those for easy stars. To me, it should be organic, hence no leaderboard.

---

## Known Issues
None that I know of. I've done my best to squash all bugs I could find and fix any inconsistencies. I've tested a wide range of situations but surely not all, if you have a problem I can be contacted on discord through the official YAGPDB [support server](https://discord.com/invite/4udtcA5) at `DV0RAK#0001`.

---

## Acknowledgements
Thanks to Joe for creating the base code for this custom command which you can see in v1. Satty, as his giveaway command gave inspiration and assistance needed for some chunks in here. A general thank you for all the people in the custom command help channel for answering some questions as well as the years-long backlog of messages I leeched off of.

---

This custom command was authored by [@dvoraknt](https://github.com/dvoraknt).