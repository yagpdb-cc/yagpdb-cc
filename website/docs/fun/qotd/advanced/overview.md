---
title: Overview
---

An advanced QOTD system which automatically posts a question every day, either a random default question or from a queue
of suggested questions from your server members.

## Features

- Permits server members to add questions to a queue.
  - Allows you to configure a queue channel to view the question queue and submit new questions.
  - Allows you to delete any question from the queue at any time.
- Posts a question in a delegated QOTD channel each day.
  - Posts the oldest question in the queue.
  - Posts a random default question if no questions in the queue.
  - Allows you to force a new question post with `qotd push`.
- Creates a new thread for each question.
  - If you set up your QOTD channel as a forum channel, the system creates a new forum post for each question.
- Publishes each question, if used in an announcement channel.
- Pings a role on each new question.
- Sticky message at the bottom of the QOTD channel reminding members what the question is.
- Completely interactive configuration setup, no config variables required.

:::info

Most of these features are configurable via the interactive setup!

:::

## Installing

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. Additionally, we've documented how and where to add these scripts down below.

### Main Command

Add the [main command](main-cc) as a new custom command. The trigger is a regex type with the trigger set to `\A`.

### Component Handler

Next, add the [component handler](component-handler) as a new custom command. The trigger is a component type with the
Custom ID set to `\Aqotd-`.

### Modal Handler

Next, add the [modal handler](modal-handler) as a new custom command. The trigger is a modal type with the
Custom ID set to `\A0?qotd-`.

### Interval Trigger

Finally, add the [interval command](interval) as a new custom command. Configure this custom command to use the hourly interval trigger type, set to `24h` (or any other interval of your choice) in an arbitrary channel.

:::note

Before saving the interval command, *disable it*, and do not enable again until after you have completed the [interactive setup](overview/#configuration).

:::

## Configuration

Now, it's time to configure your QOTD system. This is a completely interactive setup, so just run `-qotd setup` (or
replace `-` with your server's prefix) and follow the instructions.

:::danger

YAGPDB must have `View Channel`, `Send Messages`, and `Embed Links` permission in the channel you run `qotd setup` in.

:::

:::info

Once you are finished with setup, you can enable your [interval cc](#interval-trigger). If you forget to do this,
your questions will not automatically post.

:::

## Usage

### Administration

- `qotd setup` - Starts the interactive setup. Run this at any time to reconfigure QOTD.
- `qotd push` - Pushes a new question immediately
- `qotd delete [ID or -all]` - Deletes a question from the queue by ID or resets the queue to blank. ID is the
  question's place in the queue.

### Suggesting Questions

Any of the below methods will work if "Suggestions Open" was enabled during interactive setup.

- `qotd suggest [new question]` - Adds a question to the suggestion queue. Can be run anywhere YAGPDB has view and send
  messages permission.
- Buttons: Buttons are located under each question, and under the question queue message. Tap them to open a modal to type
your question into.
- Queue Channel: Sending any message in the queue channel will add a question to the queue.

:::danger

It is recommended that you either remove `Send Messages` permissions from your server members in your Queue channel, or
set an appropriate slowmode to prevent users from spamming questions.

:::

## Troubleshooting

The interactive setup catches almost every error, particularly permissions errors. If the QOTD system isn't working, a
good first step is to run `qotd setup` again and start from scratch. This will *not* clear your queued questions, you
will need to run `qotd delete -all` to do that.

## Author

This custom command system was written by [@SoggySaussages](https://github.com/SoggySaussages).
