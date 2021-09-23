---
title: Custom Command to File
---

This command removes de repeated characters
It is a useful addition to another commands that needs to compare words.

## Trigger

**Type:** `Command`

**Trigger:** `fixRL` *(Full customizable)*

## Usage

- `-fixRL <Sentence>`
- Returns the arranged sentence.

### Example

```
-fixRL Teeeeeeeeeeeesssssssttttttt
```

Will return `Test`

:::caution Title

Limitations

:::

English words like Hello would be Helo
Take this in mind if you want to use the code in another commands, when listing words to match.


## Code

```gotmpl file=../../../src/utilities/removeRepeatedLetters.go.tmpl

```

## Author

Written by [Faculord](https://github.com/LattandiFacundo).
