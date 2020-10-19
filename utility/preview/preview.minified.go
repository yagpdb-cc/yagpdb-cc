{{$a:=cslice 1048576 65536 4096 256 16 1}}{{$d:=sdict "A" 10 "B" 11 "C" 12 "D" 13 "E" 14 "F" 15}}{{$c:=.StrippedMsg}}{{$e:=or (reFind `-(d|dec)` $c) ""}}{{$f:=`(?:#?([a-fA-F\d]{1,6}))`}}{{if $e}}{{$f =`(\d+)`}}{{end}}{{with reFindAllSubmatches $f $c}}{{$g:=(printf "%06s" (index . 0 1)) | upper}}{{$h:=0}}{{with and $e (toInt (index . 0 1))}}{{$g =(printf "%06x" .) | upper}}{{$h =.}}{{end}}{{if not $h}}{{range $k, $j:=split $g ""}}{{$b:=index $a $k}}{{$i:=or ($d.Get $j) $j}}{{$h =add $h (mult $i $b)}}{{end}}{{end}}{{sendMessage nil (cembed
"title" "❯ Color Preview"
"color" $h
"description" (printf "❯ **Decimal:** %d\n❯ **Hex:** #%s" $h $g)
"thumbnail" (sdict "url" (printf "https://dummyimage.com/400x400/%s/%s" $g $g))
)}}{{else}}
Correct usage is `-preview <hex>`.
{{end}}
