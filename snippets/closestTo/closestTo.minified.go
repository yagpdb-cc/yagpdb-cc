{{$b:=1}}{{$c:=cslice 2 1.5 0.6 -1}}{{$d:=0}}{{$a:=toFloat -1}}{{range $c}}{{$e:=sub (toFloat $b) (toFloat .)}}{{if lt $e (toFloat 0)}}{{$e =mult $e -1}}{{end}}{{if or (lt $e $a) (eq $a (toFloat -1))}}{{$d =.}}{{$a =$e}}{{end}}{{end}}{{$d}}
