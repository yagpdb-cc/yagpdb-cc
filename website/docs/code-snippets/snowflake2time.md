---
sidebar_position: 8
title: Snowflake to Time
---

This code snippet extracts the underlying time of snowflakes (Discord IDs).

Sometimes, you want to get the time that, say, a user created their account / a channel was created. If you look in the documentation, that's not something that is accessible in templates. However, most Discord structures have an ID. Those IDs all have one thing in common - they use the _snowflake_ format. This format contains a timestamp, which you can extract to get the time when it was created.

:::info

For more information, see [this section](https://discord.com/developers/docs/reference#snowflakes) on the Discord developer documentation.

:::

## Code

```go file=../../../src/code_snippets/snowflake2time.go.tmpl

```

## Usage

First, add the code snippet above:

```go
{{/* code snippet goes here */}}
```

Next, change the value of `$snowflake` to your input value. Say we wanted to use `.Guild.ID` rather than `.User.ID`:

```diff {3}
{{/* Let $snowflake be the ID. }}
- {{ $snowflake := .User.ID }}
+ {{ $snowflake := .Guild.ID }}
{{/* rest of code snippet goes here */}}
```

You can now access the time when `$snowflake` was created using `$time`:

```go {2}
{{/* code snippet goes here */}}
Time `$snowflake` was created: {{$time}}
```

## Author

This code snippet was written by [@jo3-l](https://github.com/jo3-l).
