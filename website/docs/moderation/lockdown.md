---
title: Lockdown
---

Simulates a lockdown command.

It accomplishes this by deleting every message sent if the channel is locked; it does not actually change any role permissions.

:::note

The reason this command locks down channels in such a roundabout way is because modifying channel permissions directly is not supported in YAGPDB template scripting.
This may change in the future, but for now, this command is the closest you can get to a lockdown command.

:::

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A` or `.*`

## Usage

- `-lock <channel|'nil'> <amount>` - Locks down the channel provided (`nil` denotes the current channel) and deletes the `amount` most recent messages. To delete no messages, use `0` for amount. Messages from moderators will not be deleted.
- `-unlock <channel>` - Unlocks a channel previously locked using this command.

### Example

```
-lock nil 5
```

Would lock the current channel and delete the 5 most recent messages, excluding those of moderators.

## Configuration

- 📌 `$ModsRoles`<br />
  List of role IDs. A member with any one of these roles will be considered a moderator and will be exempt from lockdown.

## Code

```go file=../../../src/moderation/lockdown.go.tmpl

```

## Author

This custom command was written by [@Pedro-Pessoa](https://github.com/Pedro-Pessoa).
