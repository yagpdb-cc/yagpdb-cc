{{$p:=false}}{{$D:=sdict}}{{$L:=false}}{{$E:=false}}{{$q:=false}}{{$m:=false}}{{$F:=""}}{{$w:=""}}{{$n:=false}}{{$G:=false}}{{$x:=123456}}{{$y:=cslice}}{{$r:=false}}{{$c:=false}}{{$a:=""}}{{$s:=false}}{{$o:=.Channel.ID}}{{$H:=false}}{{$z:=""}}{{$I:=false}}{{$A:=sdict}}{{$k:=false}}{{$f:=sdict}}{{$B:=false}}{{$t:=sdict}}{{$g:=false}}{{$d:=""}}{{$h:=false}}{{$C:=false}}{{$u:=sdict}}{{$i:=false}}{{$j:=false}}{{$e:=""}}{{$l:=false}}{{$J:=sdict}}{{$K:=cslice "-channel" "-fields" "-color" "-description" "-title" "-image" "-thumb" "-author" "-footer" "-timestamp"}}{{range $k, $M:=.CmdArgs}}{{if eq . "-fields"}}{{$p =true}}{{else if in $K .}}{{$p =false}}{{end}}{{if $p}}{{$m =true}}{{if eq . "/name"}}{{$L =true}}{{$E =false}}{{$q =false}}{{else if eq . "/value"}}{{$L =false}}{{$E =true}}{{$q =false}}{{else if eq . "/inline"}}{{$L =false}}{{$E =false}}{{$q =true}}{{end}}{{if and ($L) (not (eq . "/name"))}}{{$F =joinStr " " $F .}}{{$D.Set "name" $F}}{{else if and ($E) (not (eq . "/value"))}}{{$w =joinStr " " $w .}}{{$D.Set "value" $w}}{{else if $q}}{{if eq . "true"}}{{$n =true}}{{end}}{{$D.Set "inline" $n}}{{else}}{{$D.Set "inline" $n}}{{end}}{{end}}{{if and (ne $w "") (or (and ($m) (not $p)) (and ($m) (eq $k (sub (len $.CmdArgs) 1))) (and (eq . "-fields") ($D.Get "name")))}}{{$m =false}}{{$r =true}}{{$y =$y.Append $D}}{{$D =sdict}}{{$F =""}}{{$w =""}}{{$n =false}}{{end}}{{if eq . "-color"}}{{$G =true}}{{else if in $K .}}{{$G =false}}{{end}}{{if and ($G) (not (eq . "-color"))}}{{with toInt .}}{{$r =true}}{{$x =.}}{{end}}{{end}}{{if eq . "-description"}}{{$c =true}}{{else if in $K .}}{{$c =false}}{{end}}{{if and ($c) (not (eq . "-description"))}}{{$r =true}}{{$a =joinStr " " $a .}}{{end}}{{if eq . "-channel"}}{{$s =true}}{{else if in $K .}}{{$s =false}}{{end}}{{if and ($s) (not (eq . "-channel"))}}{{$b:=reReplace `<|>|#` . ""}}{{with getChannel $b}}{{$o =.ID}}{{end}}{{end}}{{if eq . "-title"}}{{$H =true}}{{else if in $K .}}{{$H =false}}{{end}}{{if and ($H) (not (eq . "-title"))}}{{$r =true}}{{$z =joinStr " " $z .}}{{end}}{{if eq . "-image"}}{{$I =true}}{{else if in $K .}}{{$I =false}}{{end}}{{if and ($I) (not (eq . "-image"))}}{{if reFind `https?:\/\/\w+` .}}{{$r =true}}{{$A.Set "url" .}}{{end}}{{end}}{{if eq . "-thumb"}}{{$k =true}}{{else if in $K .}}{{$k =false}}{{end}}{{if and ($k) (not (eq . "-thumb"))}}{{if reFind `https?:\/\/\w+` .}}{{$r =true}}{{$f.Set "url" .}}{{end}}{{end}}{{if eq . "-author"}}{{$B =true}}{{else if in $K .}}{{$B =false}}{{end}}{{if $B}}{{if eq . "/name"}}{{$g =true}}{{$h =false}}{{else if eq . "/icon"}}{{$g =false}}{{$h =true}}{{end}}{{if and ($g) (not (eq . "/name"))}}{{$d =joinStr " " $d .}}{{$r =true}}{{$t.Set "name" $d}}{{else if and ($h) (not (eq . "/icon"))}}{{if reFind `https?:\/\/\w+` .}}{{$r =true}}{{$t.Set "icon_url" .}}{{end}}{{end}}{{end}}{{if eq . "-footer"}}{{$C =true}}{{else if in $K .}}{{$C =false}}{{end}}{{if $C}}{{if eq . "/text"}}{{$i =true}}{{$j =false}}{{else if eq . "/icon"}}{{$i =false}}{{$j =true}}{{end}}{{if and ($i) (not (eq . "/text"))}}{{$e =joinStr " " $e .}}{{$r =true}}{{$u.Set "text" $e}}{{else if and ($j) (not (eq . "/icon"))}}{{if reFind `https?:\/\/\w+` .}}{{$r =true}}{{$u.Set "icon_url" .}}{{end}}{{end}}{{end}}{{if eq . "-timestamp"}}{{$l =currentTime}}{{$r =true}}{{end}}{{end}}{{if $r}}{{$J.Set "fields" $y}}{{$J.Set "color" $x}}{{$J.Set "description" $a}}{{$J.Set "title" $z}}{{$J.Set "image" $A}}{{$J.Set "thumbnail" $f}}{{$J.Set "author" $t}}{{$J.Set "footer" $u}}{{with $l}}{{$J.Set "timestamp" .}}{{end}}{{sendMessage $o (cembed $J)}}{{end}}
