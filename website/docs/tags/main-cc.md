---
sidebar_position: 2
title: Main CC
---

Main tag command, allows users to create/update/delete/view tags.

For more information about the tag system, see [this](overview) page.

## Trigger

**Type:** `StartsWith`<br />
**Trigger:** `;`

## Usage

- `;tag add <name> <value>` - Adds a tag with the name and value given.
- `;tag del <name>` - Deletes the tag with the value given.
- `;tag addalias <name> <aliases...>` - Adds the aliases provided to the tag with the name given.
- `;tag delalias <name> <alias>` - Removes the alias from the tag with the name given.
- `;tag list` - Lists all tags.
- `;tag info <name>` - Views information about the tag with the name provided.
- `;<tag>` - Views the value of the tag given. For example, if we had a tag with the name `foobar`, `;foobar` would bring up the value of that tag.

:::note Tag name restrictions

Tag names must not contain the `|`, `_`, or `%` characters and be between 1 and 25 characters in length. This also applies to aliases.

:::

## Configuration

- 📌 `$modRoles`<br />
  List of moderator role IDs. A member with any one of these roles will be able to manage tags (aka add, delete, and update).

## Code

```go file=../../../src/tags/tags.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
