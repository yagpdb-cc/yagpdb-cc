---
title: String to Time
---

Code snippet to parse strings to a time struct, in a human friendly way.

Say you have a command that creates events (much like the `-event create` built-in command). You would like to accept a time when the event will begin. You _could_ be very strict in your parsing and make the user input their time in a very specific format, but why not allow a variety of human-friendly input like `tomorrow`, `tomorrow at 8:30pm`, and so on? That's what this code snippet does.

### Accepted Formats

**Date:**<br />

1. `dd/mm/yyyy` or `dd.mm.yyyy` or `dd-mm-yyyy` or `dd,mm,yyyy`
2. String format with year mentioned with 4 digits and both short and long month names supported. Date components (i.e day , month , year) need not be present together. eg: `12 Feb 11:50 am`, `2020` are supported.
3. `today` and `tomorrow` is supported.

**TimeZone:**<br />
By default timezone is UTC. If user has timezone set using `setz` command, timezone adjustment is also possible. UTC time is parsed if explicitly specified UTC in this case.

**Time:**<br />
Time is mentioned as `hh:mm:ss` or `hh:mm` or `hh`. May or may not be followed by AM or PM.

## Code

```go file=../../../src/code_snippets/string_to_time.go.tmpl

```

## Usage

First, add the code snippet above:

```go
{{/* code snippet goes here */}}
```

Next, change the value of `$timeString` to the value you want to parse. Say we wanted to use `.Message.Content` rather than `.StrippedMsg`:

```diff {3}
{{/* Let $timeString be the input string to be parsed. */}}
- {{ $timeString := .StrippedMsg }}
+ {{ $timeString := .Message.Content }}
{{/* rest of code snippet goes here */}}
```

You can now reference the parsed time using `$timeConverted`, which will be a _time.Time_:

```go {2}
{{/* code snippet goes here */}}
Resulting time: {{$timeConverted}}
```

## Author

This code snippet was written by [@Satty9361](https://github.com/Satty9361).
