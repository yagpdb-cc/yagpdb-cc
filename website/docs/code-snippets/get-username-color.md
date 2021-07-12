---
title: Get Username Color
---

This code snippet gets the display colour of a member.

## Code

```go file=../../../src/code_snippets/get_username_color.go.tmpl

```

## Usage

First, copy the above snippet just above where you want to get the username color. Then, you can simply reference `$col`, which will be the decimal display color of the member.

For example, the following code uses it for an embed:

```go {4}
{{/* code snippet here */}}
{{sendMessage nil (cembed
	"title" (print "Hello " .User.Username "!")
	"color" $col
)}}
```

### Getting the color for a member other than the context member

Let's say you want to get the color of a member that isn't the member that triggered the command. All you would have to change is the following:

```diff {4}
{{/* rest of code snippet */}}
{{$p := 0}}
- {{$r := .Member.Roles}}
+ {{$r := $member.Roles}}
{{range .Guild.Roles}}
{{/* rest of code snippet */}}
```

This would get the display color of `$member`, rather than the triggering member.

## Author

This code snippet was written by [@buthed010203](https://github.com/buthed010203).
