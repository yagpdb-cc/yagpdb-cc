---
title: Notes
---

import { AvailablePermissionsDisplay } from '../../src/components/AvailablePermissionsDisplay';

> A system bringing staff notes to your server.

## The Problem

As it stands, there is no good way to share notes about users across server staff and the one Discord provides is heavily limited:

- Notes can only be set on a per-user basis
- Notes can only be 256 characters long
- You cannot set multiple notes easily

On larger servers however, this may become an issue. This custom command aims to solve this problem.
It provides every functionality a server may need, that is:

- Server staff can set up to ten different notes on one individual user, maxing out at 500 characters each
- Server staff can easily view notes of each user, as well as delete them when necessary
- Server administrators can purge the entire system if need be

#### Trigger

**Type**: RegEx <br />
**Trigger**: `\A(?:\-|<@!?204255221017214977>)\s*notes?(?: +|\z)`
**Case-Sensitive**: false

:::caution

Make sure to replace `-` with your prefix, should it be different.

:::

## Usage

- `notes help`: List all subcommands
- `notes set <user> <text>`: set a note on user
- `notes get <user>`: get all user's notes
- `notes del <user> <id>`: delete given note on user
- `notes delall <user>`: delete all notes on user
- `notes nuke`: delete all ever recorded notes

## Configuration

<AvailablePermissionsDisplay />

- 📌 `$BASE_PERMISSION` <br />
This permission should be the permission which all server staff have - on most servers, this is `ManageMessages`. If you want to lock this system behind a more exclusive permission, please view the full list under `$NUKE_PERMISSION` - it lists all of them.

- 📌 `$DELETE_TIMEOUT` <br />
  This variable sets the timeout when passwords for `delall` and `nuke` should expire. It is not recommended to extend this duration beyond 5 minutes and below 10 seconds. Time intervals are specified using the formatting characters `y` for _years_, `mo` for _months_, `w` for _weeks_, `d` for _days_, `h` for _hours_, and `s` for _seconds_. Do not remove the function `toDuration`.

- 📌 `$NUKE_PERMISSION` <br />
  This permission is quite a dangerous one: It grants the ability to purge the entire system. Most servers consider users with `ManageServer` permission as an admin, hence this is the default. It is recommended to change this to a more exclusive permission rather than a common one. `Adminstrator` would be a fitting candidate, as it's a quite rarely given permission, `ManageRoles` however may not.

- 📌 `$PASSWD_CHARSET` <br />
  This variable specifies the charset a password should be generated from. It is recommended to only add more characters rather than removing some. Please be advised that there should be always a reasonably large set available to pick from, otherwise passwords may become easy to guess. Do not separate individual characters by whitespaces, simply append them.

## Code

Copy the following code:

```gotmpl file=../../../src/moderation/notes/notes_minified.go.tmpl

```

## FAQ

**Q: The command is not saving and it errors with "response too long".**

**Answer:** Make sure to use the code provided in `notes_minified.go.tmpl`. The code provided in the other file is only there to show the command in a readable, formatted manner.

**Q: The full reset is taking rather long.**

**Answer:** This may have any of the following reasons.

1. You have accumulated a quite large amount of entries in your server, which obviously will take a while to clear.
2. The delay imposed by `execCC` is set to 10 seconds to prevent hitting the limit of 10 executions per minute, per channel.
3. The command is always performing one final pass over your database, to ensure the system really is gone.

## Author

This custom command was authored by [@l-zeuch](https://github.com/l-zeuch)

## Trivia

This system implements makeshift `sdicts` purely with string manipulation used for storage -- it isn't the most efficient, but was a quite nice exercise back then. This system should serve as a useful thing to server
staff as well as an opportunity to learn :^)
