---
title: Confessions
---

## Features

- Create anonymous confessions
- Reply to anonymous confessions anonymously
- Ban offending users from confessions access without revealing who they are

## Installation

This package contains three custom commands. Only one of them is ever called, and typically only once.

**[confess_init](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_init.go.tmpl) Setup:**

Trigger Type: Exact Match or Command (your preference really)

Trigger: Whatever you like. This only needs to be ran once.

Configuration variables:

- **$DBID:** This is the ID you wish to use for database calls for confessions. Set it to whatever you like, though it is best it is unique from your other database IDs. Defaults to 1.
- **$RequiredPerms:** This is the string value of the permission you want to require a user has in order to take to run the [confess_init](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_init.go.tmpl) command ban users from confessions with the ban button. I recommend leaving this one as-is.
- **$ModalPromptPrefix:** Keep this one simple, and make sure it ends in a dash. You will need to copy whatever you set here into the Component Custom ID Regex field of the [confess_modal_prompt](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_modal_prompt.go.tmpl) command. They MUST match exactly.
- **$ModalDigestPrefix:** This works identically to the above configuration variable, but for [confess_modal_digest](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_modal_digest.go.tmpl). Again, make sure this value matches EXACTLY what you enter into this [confess_modal_digest](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_modal_digest.go.tmpl)'s Component Custom ID Regex field.

**[confess_modal_prompt](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_modal_prompt.go.tmpl) Setup:**

Trigger Type: Message Component

Component Custom ID Regex: Copy the value of **$ModalPromptPrefix**

**[confess_modal_digest](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_modal_digest.go.tmpl) Setup:**

Trigger Type: Message Component

Component Custom ID Regex: Copy the value of **$ModalDigestPrefix**


## How to begin

Simply run whatever you set as the trigger for [confess_init](https://github.com/yagpdb-cc/yagpdb-cc/tree/master/src/fun/confess_init.go.tmpl) in the channel you want it to run and you're done! The "Submit a confession!" button will show up. You can safely rerun this command if you want to create another button.

**Author**

This custom command was written by [creature-features](https://github.com/creature-features).
