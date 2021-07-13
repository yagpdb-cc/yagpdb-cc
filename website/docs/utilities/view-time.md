---
title: View Time
---

This command retrieves the time and weather of your city and displays it in a nice looking embed with a different image/color depending on time.

:::note

As you have to hardcode your time/weather/name currently this is more useful as a personal thing rather than something useful for a server.

:::

## Trigger

**Type:** `Command`<br />
**Trigger:** `time`

## Usage

- `-time` - retrieves the time and weather of your city and displays it as an embed.

## Configuration

- `$assets`<br />
  Colors and images to use for different times of the day.
  Should be quite self explanatory but each value in the dictionary corresponds to a time of day and contains an image and color decimal, which will be used for the embed.

- 📌 `$timezone`<br />
  Timezone database name (`Area/City`).

  :::tip

  You can use [this tool](https://kevinnovak.github.io/Time-Zone-Picker/) to find your timezone database name (selected the `Area/City` option).

  :::

- 📌 `$name`<br />
  Name to use for the embed.

- 📌 `$location`<br />
  Your city name (used for retrieving the weather).

## Code

```gotmpl file=../../../src/utilities/time.go.tmpl

```

## Author

This custom command was written by [@jo3-l](https://github.com/jo3-l).
