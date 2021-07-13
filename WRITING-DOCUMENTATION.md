# Writing documentation for your contributions

Writing documentation for your code can be simple (and sometimes complicated, depending on what your code does). If you're having trouble, please get in touch with us through opening an issue or contacting us through the YAGPDB Support Server.

# Introduction

This repository has a website with pages corresponding to custom commands available here.
All you need to do to add a new page is to create a new Markdown file in the proper subfolder in [`website/docs/`](./website/docs/).

For example, if you were creating a fun command, you would want to create a Markdown file in the `website/docs/fun/` folder.

# Documenting a single command

If you're adding a single command, what you need to do is pretty easy.
You simply need to copy [the template](./website/TEMPLATE.md) to the proper subfolder, and then fill out the template.

For some examples, see [the documentation for the edit command](./website/docs/utilities/edit.md) and [the documentation for the original starboard command](./website/docs/fun/starboardv1.md).

# Documenting a system of commands

If you are adding a system of custom commands, it's a bit more complicated.

## Is it hard to install?

First, consider how hard it is (relative to other commands) to install your system of custom commands. Does it have many parts users might be confused about / have a lot of complex configuration? If so, you might need to write an installation guide. We have no template for this, but there are several good examples.

See:

- [Version 2 of the giveaway system](./website/docs/giveaway/basic-v2/)
- [Version 2 of the starboard system](./website/docs/fun/starboard/)

Note the structure: there is an `overview.md`, where the installation guide lies, and several files (one for each command) around it.

## Is it easy to install?

If there's little to no configuration for your commands & you feel it's reasonably simple to install, you can skip the installation guide and instead simply write a quick overview of what your system does and then write documentation for your commands.

See:

- [The CAH Groups system](./website/docs/fun/cah-groups/)
- [The Connect4 system](./website/docs/connect-four/)

# Special Markdown features

The website documentation files support all the normal Markdown features but also have some other features.
There's too many of them to list here, but here are two common ones that we've found to be useful:

## Admonitions

Admonitions are ways to attract the user's attention to some bit of text enclosed in a box. They have the following format:

```
:::style Optional title

Text

:::
```

### Examples

<details>
	<summary>Click to expand</summary>

**Notes:**

```
:::note

Note content goes here.

:::
```

```
:::note Title

Note content goes here.

:::
```

**Tips:**

```
:::tip

Tip content goes here.

:::
```

```
:::tip Title

Tip content goes here.

:::
```

**Warnings:**

```
:::caution

Warning text goes here.

:::
```

```
:::caution Title

Warning text goes here.

:::
```

**Danger text:**

```
:::danger

Danger text goes here.

:::
```

```
:::danger Title

Danger text goes here.

:::
```

</details>

## Codeblocks linking to files

Codeblocks can link to files (useful for showing custom command code):

`./file.go.tmpl`

```
{{sendMessage nil "hello world!"}}
```

`./docs.md`

````
```gotmpl file=./file.go.tmpl

```
````

Would become:

````
```gotmpl
{{sendMessage nil "hello world"}}
```
````

---

To see all Markdown features, see [this page](https://docusaurus.io/docs/markdown-features).

---

Now that you're done reading this page, it's time to return to the [contributing guide](./CONTRIBUTING#after-you-ve-finished).
