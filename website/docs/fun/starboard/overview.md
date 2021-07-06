---
sidebar_position: 1
title: Overview
---

This is version 2 of the starboard custom command system. This package now consists of two custom commands, and more elaborate setup is required. All features of the first version are also available in this version.

## Features

All the starboard v1 features, plus the following:

- Posts automatically removed when they fall below set star threshold or when number of anti-stars has been reached.
- Ability to ignore stars/anti-stars on old posts (server customizable).
- Anti-star feature similar to an upvote/downvote system with customizable threshold for 'downvotes' before autodeleting (server customizable).
- Ability to react directly on posts in your #starboard channel with either star or anti-star.
  - Accurate tracking between original post and starboard post.
  - Users are unable to duplicate stars/anti-stars between channels.
- Reactions from the original message poster can be ignored (server customizable).
- Message warnings for attempts to duplicate stars/anti-stars and self stars (server customizable).

:::caution

Not all of these features will work on starboard messages created with the original starboard CC!

:::

## Installing

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. Additionally, we've documented how and where to add these scripts down below.

### Main Command

Add the [main command](main-cc) as a new custom command. The trigger is a reaction type with the `Added + Removed Reactions` option enabled.

:::note

The main command should be set to _ignore_ your starboard channel in the channel restrictions.

:::

Save this command for now.

### Secondary Command

Next, add the [secondary command](reaction-handler) as a new custom command. The trigger is the same as the first one: a reaction type with the `Added + Removed Reactions` option enabled.

:::note

Unlike the first command, this one should be set to _only run_ in your starboard channel in the channel restrictions.

:::

## Configuration

Now, it's time to configure your starboard system.

:::danger

Both of the commands in the system need to have the same configuration. If you change something in one command, be sure to do it in the other as well. Otherwise, unexpected things may happen!

:::

### List of configurable values

- `$starEmoji`<br />
  The name of the star emoji.

- `$starEmFull`<br />
  Full emoji name of the star emoji. If the star emoji is a default Discord emoji, this is the same as `$starEmoji`. For custom emojis, this value should be in the format `name:id`, e.g. `:pQuack:828204295824080926`.

- `$starLimit`<br />
  The threshold of stars needed for a message to show up the starboard.

- 📌 `$starboard`<br />
  The ID of the starboard channel.

- `$maxAge`<br />
  The maximum age of messages for stars to be counted. Structure is `(mo)nth`, `(w)week`, `(d)ay`, `(h)our`.
  **Example:** `3d` => 3 days, `1mo` => 1 month.

- `$selfStarEnable`<br />
  Whether users starring their own message should be counted.

- `$warnMessage`<br />
  Whether or not to warn users that star their own message. Set this to `false` if `$selfStarEnable` is `true`.

- `$antiStarEnable`<br />
  Whether _anti-star_ counting should be enabled. Anti-stars count towards the total number of stars but in a negative manner instead. For example, if a message had 3 stars and 1 anti-star, the adjusted number of stars would be 2.

- `$antiStarEmoji`<br />
  The name of the anti-star emoji.

- `$antiStarEmFull`<br />
  Full name of the anti-star emoji. See the description for `$starEmFull` for what this means.

- `$antiStarExtra`<br />
  The number of additional anti-star reactions needed before removing a post. For example, if this value were `0` (the default), the post would be removed if it had the same number of anti-star reactions as stars.

After you've configured all those variables, save again.

:::info

Your starboard system is now ready to use!

:::

## Troubleshooting

#### `Failed executing template... at <$thisID>: can't evaluate field Author in type discordgo.Message`

- You have either not set the channel permissions properly or you still have the original starboard CC active in your server. Double check that you have disabled/removed the original starboard CC and followed the install instructions above.
- This error will appear if you are trying to create starboard posts from within your starboard channel. The listener CC is not designed to create new starboard posts, it can only manage existing entries.

#### `Failed executing template... {"message": "Unknown Emoji", "code": 10014}`

- YAGPDB will accept unicode emojis (Discord default) in the format "⭐" (in both emoji variables)
- YAGPDB will accept custom emojis in the following format:
  - `"pQuack"` in `$starEmoji` or `$antiStarEmoji`
  - `":pQuack:828204295824080926"` in `$starEmFull` or `$antiStarEmFull`

## Known Issues

- Due to necessary DB trimming and the ability to ignore reactions on older messages the CC will automatically trim off the oldest data when appropriate. If you have set the date limiter to a very long duration you may have old messages getting reposted in the starboard channel when reactions are modified.

I've tested a wide range of situations but surely not all, if you have a problem I can be contacted on Discord through the official YAGPDB server at `DV0RAK#0001`.

## FAQ

#### Why did I make this?

Starboards on Discord hold a special place in my heart and I wanted one with, what I perceive to be, the most important and valuable features. Every bot with a starboard seems to lack one feature or the other, never all of them. This is what I think is a complete starboard.

#### Why is there no star leaderboard?

Personally, I don't like it. A starboard should be for funny or out of context comments, self-made memes, or similar. Having a leaderboard seems to encourage members to make low-effort, spammy, attention-seeking, or a combination of those for easy stars. To me, it should be organic, hence no leaderboard.

## Acknowledgements

Thanks to Joe for creating the base code for this custom command which you can see in v1. Satty, as his giveaway command gave inspiration and assistance needed for some chunks in here. A general thank you for all the people in the custom command help channel for answering some questions as well as the years-long backlog of messages I leeched off of.

## Author

This custom command system was written by [@dvoraknt](https://github.com/dvoraknt).
