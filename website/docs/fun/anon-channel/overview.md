---
title: Overview
---

The anonymous channel system employs modals to create a truly anonymous messaging system.

## Features

- Privately submitted anonymous messages with modals.
- YAGPDB reposts messages itself under the tag "anonymous."
- A sticky message with a button to submit an anonymous message.
- Optionally convert any message sent in the anonymous channel to an anonymous message.

## Installing

As usual, there are instructions describing where to put the script and which trigger to use on the pages corresponding to the individual commands. Additionally, we've documented how and where to add these scripts down below.

### Main Command

Add the [main command](main-cc) as a new custom command. The trigger is a regex type with the trigger set to `\A`.

:::danger

The main command should be set to _only run in_ your anonymous channel in the channel restrictions.

:::

Save this command for now. Send a message in your anonymous channel to have the bot send the initial sticky message.

### Secondary Command

Next, add the [secondary command](component-handler) as a new custom command. The trigger is a component type with the
custom ID set to `\Aanon_submit\b`.

### Final Command

Finally, add the [third command](modal-handler) as a new custom command. The trigger is a modal type with the
custom ID set to `\A0?anon_submit\b`.

## Configuration

Now, it's time to configure your starboard system.

### List of configurable values

- `$all_anon`<br />
  Configured in the **main cc**. Whether or not to repost any messages sent in the anonymous channel anonymously.

- 📌 `$main_cc_id`<br />
  Configured in the **modal-handler cc**. The custom command ID of the main cc.

After you've configured all those variables, save again.

:::info

Your anonymous channel is now ready to use!

:::

## Author

This custom command system was written by [@dvoraknt](https://github.com/dvoraknt).
