---
title: Staff On Duty
---

On-duty staffing system. You will need to set up an "on duty" role pingable by members.

The idea behind this CC is to have an easy way for server members to ping only the staff who have self designated themselves as available to moderate. In most servers pinging staff is discouraged to the point that people won't do it even when swift moderation is necessary. By providing an encouraged method of reaching only the active staff members, it should provide faster response time to issues without members needing to ping a specific person who may or may not be available.

## Features

- Adds/removes an "on duty" role of your choice
  - Automatically adds back "only duty" role to staff who've manually removed the role but are designated as on duty.
- Updates channel topic in a given channel to provide a visible on duty staff list
  - Respects Discord ratelimits for channel updates
  - Keeps user defined channel topic intact
- Automatically removes staff from the list after a time
- List on-duty staff using `-onduty list`
- Manually remove staff from the list using `-offduty <user>`
- Force update the channel topic using `-onduty update`

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A(-|<@!?204255221017214977>\s*)(o(n|ff)duty)(\s+|\z)`

:::caution

Unless you would like everyone to be able to use these commands, we advise that you limit it to a staff role in the role restrictions.

:::

## Usage

- `-onduty` - Mark yourself as on duty.
- `-onduty list` - Display a list of staff members designated as on duty and reassign on duty role if needed.
- `-onduty update` - Force an update of the channel topic. Will update five minutes after the command is ran.
- `-offduty` - Mark yourself as off duty.
- `-offduty <user>` - Manually mark the specified user as off duty.

:::caution Limitations

1. On non-premium servers, the `onduty` command will occasionally require an additional command to be run.

2. This command was built around channel topic editing. You can use it without editing the topic but certain actions will be unnecessary or delayed.

:::

## Configuration

- 📌 `$dutyRole`<br />
  ID of your "on duty" role.

- `$autoOff`<br />
  Number of hours before on duty role is automatically removed.

- 📌 `$dutyChannel`<br />
  ID of the channel where the topic should be updated periodically.

- `$chanEdit`<br />
  Whether or not channel topic editing is enabled.

## Code

```gotmpl file=../../../src/moderation/staff_on_duty.go.tmpl

```

## Author

This custom command was written by [@dvoraknt](https://github.com/dvoraknt).
