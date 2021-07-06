---
sidebar_position: 4
title: Ordinal
---

This code snippet gets the ordinal corresponding to a given integer. For example, the ordinal of 1 would be `st`, `nd` for 122, and so on.

:::tip

This may be useful for join feeds - showing `You're the 5th member` is nicer than `You're member #5`.

:::

## Code

```go file=../../../src/code_snippets/ordinal.go.tmpl

```

## Usage

First, add the code snippet:

```go
{{/* code snippet goes here */}}
```

Next, change the value of `$int` to what you want:

```diff {3}
{{/* Let $int be the integer. */}}
- {{ $int := 123 }}
+ {{ $int := .Guild.MemberCount }}
{{/* Rest of snippet goes here */}}
```

And that's it! `$ord` will be the ordinal for the integer `$int`.

```go {2}
{{/* code snippet goes here */}}
You are the {{$int}}{{$ord}} member!
```

## Author

This code snippet was written by [@jo3-l](https://github.com/jo3-l).
