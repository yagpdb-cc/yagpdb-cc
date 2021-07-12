---
title: Binary Search
---

This code snippet searches for a value in a sorted slice/array in _O(log n)_ using the [binary search](https://en.wikipedia.org/wiki/Binary_search_algorithm) algorithm.

## Code

```go file=../../../src/code_snippets/binary_search.go.tmpl

```

## Usage

First, copy the above snippet to the top of your code.<br />
To use it, you will need to construct a map holding your input slice/array in addition to the value you wish to search for:

```go
{{/* code snippet here */}}
{{$query := sdict "List" (cslice 1 2 3 5 7 8) "Value" 2 "Found" true}}
```

:::note

`"Found" true` tells the template to begin searching in the slice/array, so make sure to set it!

:::

Then, we can run the template, passing the query as data:

```go {3}
{{/* code snippet here */}}
{{$query := sdict "List" (cslice 1 2 3 5 7 8) "Value" 2 "Found" true}}
{{template "binary_search" $query}}
```

Running the template will add a new value to your map, `Result`, which is the index where the element was found, or `-1` if it wasn't found. We can access it using dot notation or `index`, like such:

```go {4}
{{/* code snippet here */}}
{{$query := sdict "List" (cslice 1 2 3 5 7 8) "Value" 2 "Found" true}}
{{template "binary_search" $query}}
Index: {{$query.Result}}
```

## Author

This code snippet was written by [@alikuxac](https://github.com/alikuxac).
