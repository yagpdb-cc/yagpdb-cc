---
title: Guess the Number
---

This command runs a "guess the number" game where users send numbers between 1 and 100. The winner wins credits!

## Trigger

**Type:** `Regex`<br />
**Trigger:** `\A`

## Usage

- Type `31` to start the game in the game channel.
- Follow the instructions after!

## Configuration

- 📌 `$channel`<br />
  Channel ID where the game is played.

- `$prize`<br />
  Number of credits for the user that wins.

- 📌 `$db`<br />
  Database entry name where the credits are stored.

- 📌 `$logs`<br />
  Channel to send logs about the game to. Set to `0` to disable logging.

- `$information`<br />
  Whether hints should be sent.

- `$infoat`<br />
  How many wrong answers need to be sent before hints are displayed.

## Code

```gotmpl file=../../../src/fun/guess_the_number.go.tmpl

```

## Author

This custom command was written by [@DaviiD1337](https://github.com/DaviiD1337).
