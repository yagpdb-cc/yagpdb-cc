---
title: Selection Sort
---

Code snippet for sorting an array/slice of comparable values of the same type in-place, using the [selection sort](https://en.wikipedia.org/wiki/Selection_sort) algorithm.

:::danger

Though this works fine for small slices/array, due to the inefficient nature of selection sort, running it on "large" slices/arrays (over 200-300 elements) will result in a runtime error. If you want to use this snippet, be careful and constrain your input sizes.

:::

## Code

```go file=../../../src/code_snippets/selection_sort.go.tmpl

```

## Usage

First, add the code snippet above:

```go
{{/* code snippet goes here */}}
```

Next, change the value of `$arr` to the value you want to sort:

```diff {3}
{{/* Let $arr be the array/slice to sort. */}}
- {{ $arr := cslice 1 38 -1 83 -4 5 1 0 }}
+ {{ $arr := theSliceIWantToSort }}
{{/* rest of code snippet goes here */}}
```

Voila, `$arr` is now sorted! You can check that it was by outputting `$arr`:

```go {2}
{{/* code snippet goes here */}}
`$arr` after sorting: `{{json $arr}}`
```

### Sorting in ascending order

You may have noticed that the above snippet sorts the array in descending order by default - larger numbers come first. That may not be desirable for your use case; perhaps you want smaller numbers to come first. In that case, you just have to change `lt` to `gt` in the following part of the code:

```diff {4}
{{/* rest of code snippet */}}
{{- range seq (add . 1) $len }}
-	{{- if lt (index $arr $min) (index $arr .) }} {{- $min = . }} {{- end -}}
+	{{- if gt (index $arr $min) (index $arr .) }} {{- $min = . }} {{- end -}}
{{- end }}
{{/* rest of code snippet */}}
```

## Author

This code snippet was written by [@jo3-l](https://github.com/jo3-l).
