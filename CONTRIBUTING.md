# Contributing

Thanks for considering a contribution to **yagpdb-cc**. We accept contributions of all shapes and forms, whether it be a new command, bugfix for an existing one, a typo fix, or something else. We have some guidelines that contributors should follow, which are detailed below.

# Folder structure

To understand how this repository is structured:

- [`src/`](./src/) is where the custom command code is stored.
- [`website/docs/`](./website/docs/) is where the documentation (part of the website) is stored.

# Guide

As noted above, there's a few things you have to do before contributing a new command to this repository. The sections below serve as a guide for new contributors.

> **Note:** If you have questions, feel free to DM a project maintainer on Discord, ask in `#programming-discussion` channel on the YAGPDB support server, or open an issue here on GitHub.

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

One of the cool things about this repository is that we have a website! What's pretty cool about it is that you can write normal Markdown - the file format of what you're reading right now - and have it come out looking like a consistently styled document.

All you need to do if you're adding a single command, really, is the following:

- Clone the [template](website/TEMPLATE.md) into `docs/some-folder/command-name.md`, e.g. `docs/fun/my-new-command.md`.
- Fill out the values in the template to match your command.
- That's it!

If you need some examples, [the documentation for the edit command](./website/docs/utilities/edit.md) and [the documentation for the original starboard command](./website/docs/fun/starboardv1.md) are decent examples.

If you are adding a system of custom commands, it's a bit more complicated.

### Is it hard to install?

First, consider how hard it is (relative to other commands) to install your system of custom commands. Does it have many parts users might be confused about / have a lot of complex configuration? If so, you might need to write an installation guide. We have no template for this, but there are several examples.

See:

- [Version 2 of the giveaway system](./website/docs/giveaway/basic-v2/)
- [Version 2 of the starboard system](./website/docs/fun/starboard/)

Note the structure: there is an `overview.md`, where the installation guide lies, and several files (one for each command) around it.

### Is it easy to install?

If there's little to no configuration for your commands & you feel it's reasonably simple to install, you can skip the installation guide and instead simply write a quick overview of what your system does and then write documentation for your commands.

See:

- [The CAH Groups system](./website/docs/fun/cah-groups/)
- [The Connect4 system](./website/docs/connect-four/)

# How do I request for my code to be added?

After you've followed these steps, you are now ready to make a **Pull Request** (PR) to this repository. Take a look at [this article](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) if you aren't quite familiar with PRs or need a refresher. We have a PR description template in place that we recommend you follow.

## What then?

All you have to do is wait for your code to be reviewed and accepted. Please note that not all PRs are guaranteed to be accepted - we only accept custom commands that are of use to many people. If your PR is denied, don't take it as meaning that your CC is bad - it just doesn't fit in this repository.

Thanks again for considering a PR!
