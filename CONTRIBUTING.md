# Contributing

Thanks for considering a contribution to **yagpdb-cc**. We accept contributions of all shapes and forms, whether it be a new command, bugfix for an existing one, a typo fix, or something else. We have some guidelines that contributors should follow, which are detailed below.

# Folder structure

To understand how this repository is structured:

- [`bin/`](./bin/) is a collection of short scripts for maintainers to help with keeping the repository tidy.
- [`src/`](./src/) is where the custom command code is stored.
- [`website/docs/`](./website/docs/) is where the documentation (part of the website) is stored.

# Guide

As noted above, there's a few things you have to do before contributing a new command to this repository. The sections below serve as a guide for new contributors.

> **Note:** If you have questions, feel free to DM a project maintainer on Discord, ask in the `#programming-discussion` channel on the YAGPDB support server, or open an issue here on GitHub.

## Add a leading comment

Add a brief comment to the start of your custom command explaining, in 1-2 sentences, what your custom command does. To repeat, this is _not the place for an essay_. Simply summarize what your command does. Do not include how to use it, its trigger, or any other information.

**Good:**<br>

```
Does foo bar baz buz.
```

**Bad:**<br>

```
This command does foo bar baz buz.

Command usage:
	-foo
	-foo xyz

Trigger Type: Command
Trigger: foo
```

After that, add some information about you - the author. It should be in the following format:

```
Author: name <https://github.com/your-handle-on-github>
```

An example would be `Author: jo3-l <https://github.com/jo3-l>`.

### Example

Let's say this was your original code:

```
{{sendMessage nil "Hello world, YAGPDB!"}}
```

This might be your code after:

```
{{/*
	Sends a greeting to YAGPDB in the chat.

	Author: jo3-l <https://github.com/jo3-l>
*/}}

{{sendMessage nil "Hello world, YAGPDB!"}}
```

We're not done with this comment, but we'll come back to it later.

## Add the code itself

Now, it's time to add the code itself to the repository. First, you'll need to figure out which category your command best fits into. The above command might be considered a tool/utility, which would go in `src/utilities/`. It could also be considered a fun command, in which case it would go into `src/fun/`. In any case, don't worry too much about this - when you make your PR, we'll comment during the review if the category you chose was not the best.

> **Note:** If you are adding several custom commands as part of a set, you should first create a folder to hold your custom commands and then add them. For example, if when adding several commands that are part of a tic-tac-toe game, add a folder called `src/fun/tictactoe/` and add your commands there, not directly in `src/fun/`.

### Naming conventions

- Use `snake_case` for folders and for files: `foo_bar/baz_buz.go.tmpl`, not `fooBar/bazBuz.go.tmpl`.
- Use the file extension `.go.tmpl`, for _Go template_.

### Configuration variables

This is the only big code change you may have to make. If there is something that a user might need/wish to change in your code, you should extract it into a _configuration variable_. For example, let's say we had some code that checks if a user has a role. Your code might look like this:

```
{{if hasRoleID 123}}
	Yes, you have the role.
{{else}}
	No, you don't have the role.
{{end}}
```

A user would probably want to change `123` to their own role ID, so we should probably extract it into a _configuration variable_. There is a special section where configuration variables go: right below your leading comment, which you should've added earlier, and before your actual code.

```
{{/*
	Leading comment goes here.
*/}}

{{/* Configuration values */}}
{{$roleID := 123}}
{{/* End of configuration values */}}

{{if hasRoleID $roleID}}
	Yes, you have the role.
{{else}}
	No, you don't have the role.
{{end}}
```

Now, you're done with changes to your code. It's time to write summon your inner writer and some documentation for your command.

## Write some documentation for the website

> **Note:** We know this part can be a bit confusing, so feel free to open an issue or just skip this part and ask for help when you make a Pull Request to the repository.

Documentation is very important if you plan on contributing to this repository. As it's a bit complicated, we have a [page dedicated to explaining it](./WRITING-DOCUMENTATION.md) to it. which you should read now.

## After you've finished...

Almost done! All you need to do now is to link to the website page in the code in the leading comment. The URL will be `https://yagpdb-cc.github.io/path/to/file`. For example, if the path to the documentation file was `website/docs/fun/my-command`, the URL would be `https://yagpdb-cc.github.io/fun/my-command`.

Change your leading comment to use the following format:

```
Brief description of command.

See <LINK> for more information.

Author: name <https://github.com/your-handle-on-github>
```

For example, for our previous example with `sendMessage`, the final code might be:

```
{{/*
	Sends a greeting to YAGPDB in the chat.

	See <https://yagpdb-cc.github.io/fun/send-greeting>

	Author: jo3-l <https://github.com/jo3-l>
*/}}

{{sendMessage nil "Hello world, YAGPDB!"}}
```

And you're done! Time to [open a PR](#how-do-i-request-for-my-code-to-be-added) : )

# How do I request for my code to be added?

After you've followed these steps, you are now ready to make a **Pull Request** (PR) to this repository. Take a look at [this article](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) if you aren't quite familiar with PRs or need a refresher. We have a template for the PR description in place that we recommend you follow.

## What then?

All you have to do is wait for your code to be reviewed and accepted. Please note that not all PRs are guaranteed to be accepted - we only accept custom commands that are of use to many people. If your PR is denied, don't take it as meaning that your CC is bad - it just doesn't fit in this repository.

Thanks again for considering a PR!
