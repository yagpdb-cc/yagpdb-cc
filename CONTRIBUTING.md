# Contributing

Thanks for considering a contribution to **yagpdb-cc**. We accept contributions of all shapes and forms, whether it be a new command, bugfix for an existing one, a typo fix, or something else. Please note that we have a few guidelines that we expect contributors to follow, detailed below.

## Guidelines

As noted above, there's a few things you have to do before PRing a new command to this repository.

**Leading comment**<br>
Add a brief comment at the start of your custom command code explaining what your command does and any setup required. This should include the trigger & trigger type in addition to any restrictions recommended. This is also the place to put information about you, the author. This is the most complicated step, so we've including an example below.

Let's say this was your original code:

```go
{{ sendMessage nil "Hello world, Yag-chan!" }}
```

This would be your code afterwards:

```go
{{/*
	This command sends a greeting in the chat.

	Usage: "-helloyag"

	Recommended trigger: "helloyag"
	Trigger type: Command

	Credits:
	Joe L. <https://github.com/Jo3-L>
*/}}

{{ sendMessage nil "Hello world, Yag-chan!" }}
```

Note that we did not include the Discord tag, only the name (if you wish) and the GitHub link. This is because tags can change, and it's rather troublesome keeping up with all the changes. A better idea is to include your Discord tag in your GitHub profile description, so you can edit it whenever.

**Configuration variables**<br>
Extract all configuration data in your code to local variables defined at the top of your code, right after the comment. For example, let's say you had a code that checks if a user has a hardcoded role ID. Your code might have looked like this:

```go
{{ if hasRoleID 123 }}
	Yes, you have the role.
{{ else }}
	No, you do not have the role.
{{ end }}
```

`123` is the role ID here. You've probably put in your own role ID, but obviously, this doesn't really work for anyone outside your server as they have a different role ID. As such, you can extract it into a local variable like such:

```go
{{/* Configuration variables start */}}
{{ $ROLE_ID := 123 }} {{/* The role ID you want to check. */}}
{{/* Configuration variables end */}}

{{ if hasRoleID $ROLE_ID }}
	Yes, you have the role.
{{ else }}
	No, you do not have the role.
{{ end }}
```

We named our configuration variable `ROLE_ID`, in UPPER_SNAKE_CASE, as it makes it clear that it is a constant. Note that this is not required, just recommended.

You'll notice that we added comments around our configuration variables. These serve as a hint to the end user that they should not be editing anything beyond this part (`Configuration variables start` and `Configuration variables end` signal the start and end of what they should edit). In addition, they provide information about what data they should put in, in this case, the role ID.

**Formatting**<br>
We don't have any particular formatting guidelines other than that your code should be relatively readable. That doesn't mean that it has to be beautiful or even indented, but it shouldn't be one super long line with single-character variable names.

Don't worry about code length if it's long - we run a minifier on code after it is accepted which does a very good job of making the code as short as possible.

## How do I request for my code to be added?

After you've followed these steps, you are now ready to make a **Pull Request** to this repository. Take a look at [this article](https://docs.github.com/en/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request) if you aren't quite familiar with PRs or need a refresher. We have a PR template in place that we recommend you follow.

If you're PRing a single command, all you have to do is add it in the appropriate folder (for example, a send message command might go in `tools/`) and then add an appropriately named file, i.e `sendMessage.gotmpl`.

If you're PRing a system of commands (i.e. a leveling system), then it's slightly more complicated. You should find an appropriate folder to place your code in (a leveling system would fit right in at `fun/`, for example) and then add a subfolder. In this case, we might want to call it `leveling`, so our file path at this point would be `fun/leveling/`.

You should then add a `README.md` describing your system and then add your individual files with appropriate names (for example, `manageSystem.gotmpl` and `giveExperience.gotmpl` might be good names for some components of a leveling system).

### What then?

All you have to do is wait for your code to be reviewed and accepted. Please note that not all PRs are guaranteed to be accepted - we only accept custom commands that are of use to many people. If your PR is denied, don't take it as meaning that your CC is bad - it just doesn't fit in this repository.

Thanks again for considering a PR!
