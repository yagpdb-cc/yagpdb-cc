# Contributing
This is a general list of personal standards I use for my code. However, I don't expect contributors to use the same standards as I personally write my CCs with.

## How to
First, you will need to follow the instructions **below**. Then, open a pull request!

## What you need to do
There are four things I expect you to do:
* add a leading comment at the top of your file
* add your CC in its own folder in the appropriate section, named `<ccName>.cc.go` where ccName is your CC name
* If your command requires any configuration (variables, etc.) explain that in the syntax provided below.
* If it's a system of commands, add a new folder and add a `README.md` file in it.

### Leading comment syntax
The following syntax is recommended for comemnts:
```go
{{/*
	<Comment>
*/}}
```
Note the indent and the space right after the comment. The comment should be like this:
```go
<Description> <Usage>

Recommended trigger: <Trigger Type> trigger with trigger `<Trigger>`.
```

If you have any doubts, feel free to ask me or look at the syntax in the existing files.

An example of a complete leading comment would be:
```go
{{/*
	This command sends the message "hello world" in the channel. Usage: `-helloworld`.

	Recommended trigger: Command trigger with trigger `helloworld`.
*/}}
```

### Configuration
If your command requires configuration, it should be done through appropriately named variables at the TOP of the file, right after the leading comment (above). For example:

```go
// Leading comment

{{/* CONFIGURATION VALUES START */}}
{{ $location := "The moon" }} {{/* Appropriate description of what this variable does */}}
<Other configuration values>
{{/* CONFIGURATION VALUES END */}}

// The code
```

That's all you need to do! Thanks for contributing, I appreciate it!

## My personal guidelines for CCs
*Note: I DO NOT REQUIRE ANY OF THESE ITEMS IN YOUR PULL REQUEST, ONLY THE THINGS STATED ABOVE*

This is the guidelines I use for the CCs I create. I may refactor your code when I'm doing a routine cleanup, so to avoid any confusion over what I'm doing:
* `parseArgs` over manually parsing `.CmdArgs`
* `print` or `printf` for string concatenation rather than `joinStr` - joinStr should generally only be used for joining a string slice.
* spaces after `{{` and before `}}` (only one, no spaces after `(` and `)` )
