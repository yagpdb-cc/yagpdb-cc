---
title: Parse Flags
---

This code snippet provides a reusable template which you can add to your custom commands.  
It separates predefined flags from positional arguments within input, for example:

`-command -m 123 positional arg -f`
might be parsed into:

```yaml
positional:
	- positional
	- arg
flags:
	m: '123'
	f: true
```

## Code

```gotmpl file=../../../src/code_snippets/parse_flags.go.tmpl

```

## Usage

First, copy the above snippet to the top of your code.<br />
To use it, you will need to construct a map holding the flags, switches, and input argument slice to parse.

In this example, we will be parsing a command similar in structure to the `rolemenu create` built-in command.

```gotmpl
{{/* code snippet goes here */}}
{{$query := dict
	"Flags" (dict
		"-m" "MessageID"
		"-msg" "MessageID"

		"-skip" "Skip"
		"-s" "Skip"
	)

	"Switches" (dict
		"-nodm" "NoDM"
		"-rr" "RemoveRole"
	)

	"Args" .CmdArgs
}}
```

:::tip
Flags take on the value that is after them, while switches are simple on-off switches (hence the name).
:::

Now, let's run the template, passing our query as the data:

```gotmpl {18}
{{/* code snippet goes here */}}
{{$query := dict
	"Flags" (dict
		"-m" "MessageID"
		"-msg" "MessageID"

		"-skip" "Skip"
		"-s" "Skip"
	)

	"Switches" (dict
		"-nodm" "NoDM"
		"-rr" "RemoveRole"
	)

	"Args" .CmdArgs
}}
{{template "parseFlags" $query}}
```

Running the template causes our input map to be filled with the parsed data, which we can access via `$query.Out`.

### Flags

Access flags by their ID (the value in the map supplied to parseFlags).
The value will be nil if the user did not supply that flag; otherwise it will
be the argument directly after the flag. For example, $msgID would have the value "1"
if the input was "-m 1".

**Example:** `{{$msgID := $query.Out.Flags.MessageID}}`

### Switches

Same thing for switches. In this case, the value will be nil if the user did not supply
that switch; otherwise it will be 'true'.

**Example:** `{{$nodm := $query.Out.Switches.NoDM}}`

### Positional arguments

Finally, we can access any excess arguments that are neither flags nor switches by indexing
into the Positional slice. In this case, $first would have the value "a" if the input was
"a -nodm -m 123".

**Example:** `{{$first := index $query.Out.Positional 0}}`

## Author

This code snippet was written by [@jo3-l](https://github.com/jo3-l).
