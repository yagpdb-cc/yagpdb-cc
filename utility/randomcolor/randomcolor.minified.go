{{$a:=randInt 0 16777216}}{{$b:=printf "%06x" $a}}{{sendMessage nil (cembed
"title" "❯ Random Color"
"color" $a
"description" (printf "❯ **Decimal:** %d\n❯ **Hex:** #%s" $a $b)
"thumbnail" (sdict "url" (printf "https://dummyimage.com/400x400/%s/%s" $b $b))
)}}
