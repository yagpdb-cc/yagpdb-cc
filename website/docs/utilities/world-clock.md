---
sidebar_position: 18
title: World Clock
---

This command shows the current time in various cities around the world.

## Trigger

**Type:** `Command`<br />
**Trigger:** `worldclock`

## Usage

- `-worldclock` - Shows the current time in various cities around the world.

## Changing the cities used

To change the cities displayed, just modify the `$clocks` variable.
The key is the city name and the value is its timezone database name.

:::tip

To get the latter value, you can use [this tool](https://kevinnovak.github.io/Time-Zone-Picker/) to find it (select the `Area/City` option).

:::

## Code

```go file=../../../src/utilities/world_clock.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
