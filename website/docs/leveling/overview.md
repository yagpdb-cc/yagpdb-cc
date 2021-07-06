---
sidebar_position: 1
title: Overview
---

This custom command system adds leveling functionality to your server, like that of MEE6 or other leveling bots.

## Features

- **Role rewards:** One per level from level 1 to 200
- **Different types of role rewards:** Stack and highest mode allow you to customize how role rewards are given
- **Easy setup:** No need to configure anything in the code; instead, run setup commands in Discord
- **Configurable:** Configure the amount of experience to give, the cooldown between messages, and so on.
  - Of course, as this is a custom command, you can change essentially anything!

## Installation

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. You will need to add all of the following commands for the system to work as expected:

- [Configure role rewards](configure-role-rewards)
- [Configure leveling system settings](configure-settings)
- [Message handler](message-handler)
- [Reaction handler](reaction-handler)
- [Set experience/level](set-xp)
- [View leaderboard](view-leaderboard)
- [View rank](view-rank)

As the initial setup for these commands is fairly straightforward, we'll leave it at that. Please refer to the instructions in the pages linked above if you have any other questions.

After you have added all the commands above, please continue to the next section for configuring your leveling system.

## Configuration

The leveling system is heavily customizable, both via code and configuration commands. We've documented some common things people like to change and how to do it below.

### Initial setup

To start using your leveling system with the default setup, simply run `-leveling use-default`. You should see a message along the lines of `Done! You are now using the default settings for the leveling system`.

:::info

At this point, your leveling system should be usable! Feel free to give it a go by sending some messages and running some of the other commands.

:::

### Customizing your leveling system

There are many things you can change regarding the leveling system using commands. We have included some common configuration commands below for convenience.

#### Rank cards

This is one of the few things you do have to configure via code in this system. The [view rank](view-rank) command has some configuration values you can modify to enable displaying rank cards. See the page corresponding to that command for more details.

#### Adding role rewards

To add role rewards, you can run `-role-rewards add <level> <role_name>`.

:::tip

To view all commands related to role rewards, simply run `-role-rewards` with no arguments, which will display a help message.

:::

#### Customizing the cooldown/experience given

- To configure the **cooldown between messages**, run `-leveling set cooldown <duration>`; for example, `-leveling set cooldown 1 minute`.
- To configure the **amount of experience given**, use the `-leveling set min <num>` and `-leveling set max <num>` commands. The way the leveling system works is that it gives between `min` and `max` experience every message, so to give between 20 and 25 experience, you would run `-leveling set min 20` and `-leveling set max 25`.

:::tip

To view all commands that are part of the general leveling settings, simply run `-leveling` with no arguments, which will display a help message.

:::

### Common modifications to the code

As these are custom commands, you can modify them however you wish if you are familiar with YAGPDB's template scripting system. There are some common modifications people like making to the code, some of which are so popular we have included additional information about below.

#### Changing the formula used for levels

:::danger

Changing the formula used for levels is a fairly involved change which will require modifying several commands and some mathematical knowledge. If you do it incorrectly unexpected behaviour can easily occur. Proceed with caution.

:::

The default formula used for levels is `f(x) = 100x^2` where `f(x)` is a function mapping levels to the experience required for that level. If you would like to change it, you need to do the following:

- Come up with an alternative function. In this example, we will change it to a simple linear function: `f(x) = 50x`. We would write this in YAGPDB templates as `mult 50 $level`.

- Derive the [_inverse function_](https://en.wikipedia.org/wiki/Inverse_function) of the function you found above. The leveling system needs this to compute the level of a user given their experience - _if user x has y xp, what is their level?_.

  In our case, the inverse function would be `f'(x) = x / 50`. Since levels must be integers, we round the result down to get our final function: `g(x) = floor(x / 50)`. We would write this in YAGPDB templates as `roundFloor (fdiv $xp 50)`.

- Now, you need to modify the following scripts to use your new formulae:
  - The [message handler](message-handler), so that it can check whether a user has leveled up.
  - The [reaction handler](reaction-handler), so it can compute the level of a user given their experience.
  - The [set experience/level](set-xp) command, so it can check whether a user has leveled up in addition to compute the new experience for a user if a level was provided.
  - The [leaderboard](view-leaderboard), for similar reasons to the reaction handler.
  - The [view rank](view-rank) command, so it can display the current progress towards the next level, the experience needed to get to the next level, and the current level of the user.

#### Customizing the levelup message

Level-up messages are sent in the [message handler](message-handler). Search for `You've leveled up to level` in the code to find the place to change.

## Author

This custom command system was authored by [@jo3-l](https://github.com/jo3-l).
