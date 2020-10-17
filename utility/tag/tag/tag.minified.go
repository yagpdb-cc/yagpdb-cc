{{$k:=reFind "^tags? *" .StrippedMsg}}{{$b:=`^[^\|_%]{1,25}$`}}{{define "getTag"}}{{$e:=lower .Name}}{{$s:=0}}{{$f:=dbTopEntries (printf "tg.%%|%s|%%" $e) 1 0}}{{if len $f}}{{$s =index $f 0}}{{end}}{{.Set "Tag" $s}}{{end}}{{if $k}}{{$t:=""}}{{$m:=cslice}}{{if gt (len .CmdArgs) 1}}{{$t =index .CmdArgs 1}}{{end}}{{if gt (len .CmdArgs ) 2}}{{$m =slice .CmdArgs 2}}{{end}}{{if and (eq $t "add") (ge (len $m) 2)}}{{$e:=index $m 0 | lower}}{{$a:=slice $m 1 | joinStr " "}}{{if reFind $b $e}}{{$n:=sdict "Name" $e}}{{template "getTag" $n}}{{if not $n.Tag}}{{dbSet 0 (printf "tg.|%s|" $e) $a}}
Successfully added a tag with the name `{{$e}}`.
{{else}}
That tag already exists.
{{end}}{{else}}
Tag names must not contain the `|`, `_`, or `%` character and be under 25 characters!
{{end}}{{else if and (eq $t "del") (len $m)}}{{$c:=joinStr " " $m}}{{$n:=sdict "Name" $c}}{{template "getTag" $n}}{{with $n.Tag}}{{dbDelByID .UserID .ID}}
Successfully deleted the tag `{{index (split (slice .Key 4 (sub (len .Key) 1)) "|") 0}}`!
{{else}}
Sorry, that tag does not exist.
{{end}}{{else if and (eq $t "info") (len $m)}}{{$e:=joinStr " " $m}}{{$n:=sdict "Name" $e}}{{template "getTag" $n}}{{with $n.Tag}}{{$g:=split (slice .Key 4 (sub (len .Key) 1)) "|"}}{{$o:=""}}{{if ge (len $g) 2}}{{range $k, $ := slice $g 1}}{{if $k}}{{$o =joinStr "" $o ", `" . "`"}}{{else if .}}{{$o =printf "`%s`" .}}{{end}}{{end}}{{end}}{{sendMessage nil (cembed
"title" "❯ Tag Info"
"color" 14232643
"fields" (cslice
(sdict "name" "❯ Name" "value" (index $g 0))
(sdict "name" "❯ Aliases" "value" (or $o "n/a"))
(sdict "name" "❯ Created At" "value" (.CreatedAt.Format "Jan 02, 2006 3:04 PM"))
)
)}}{{else}}
That tag does not exist. Try again?
{{end}}{{else if and (eq $t "edit") (ge (len $m) 2)}}{{$e:=index $m 0}}{{$a:=slice $m 1 | joinStr " "}}{{if reFind $b $e}}{{$n:=sdict "Name" $e}}{{template "getTag" $n}}{{with $n.Tag}}{{dbSet 0 .Key $a}}
Successfully edited the content of the tag `{{$e}}`.
{{else}}
Sorry, that tag does not exist!
{{end}}{{else}}
That tag does not exist!
{{end}}{{else if and (eq $t "addalias") (ge (len $m) 2)}}{{$e:=index $m 0}}{{$g:=slice $m 1}}{{$l:=true}}{{$u:=printf "tg.|%s|" $e}}{{range $k, $ := $g}}{{if not (reFind $b .)}}{{$l =false}}{{else if $k}}{{$u =joinStr "" $u "|" (lower .)}}{{else}}{{$u =joinStr "" $u (lower .)}}{{end}}{{end}}{{if and (reFind $b $e) $l}}{{$n:=sdict "Name" $e}}{{template "getTag" $n}}{{with $n.Tag}}{{dbDelByID .UserID .ID}}{{$i:=joinStr "" $u "|"}}{{if gt (len $i) 256}}
Sorry, that alias was too long. Try again.
{{else}}{{dbSet 0 (joinStr "" $u "|") .Value}}
Successfully added {{len $g}} aliases to the tag `{{$e}}`!
{{end}}{{else}}
Sorry, that tag does not exist.
{{end}}{{else}}
Sorry, some aliases provided were not valid! Try again.
{{end}}{{else if and (eq $t "delalias") (ge (len $m) 2)}}{{$e:=index $m 0}}{{$d:=slice $m 1 | joinStr " " | lower}}{{$n:=sdict "Name" $e}}{{template "getTag" $n}}{{with $n.Tag}}{{$g:=split (slice .Key 4 (sub (len .Key) 1)) "|"}}{{$e:=printf "tg."}}{{if eq (len $g) 1}}
Sorry, you cannot remove an alias from a tag with only 1 alias.
{{else}}{{range $g}}{{if ne $d .}}{{$e =joinStr "" $e "|" .}}{{end}}{{end}}{{$e =joinStr "" $e "|"}}{{dbDelByID .UserID .ID}}{{dbSet 0 $e .Value}}
Successfully removed alias!
{{end}}{{else}}
That tag does not exist.
{{end}}{{else if eq $t "list"}}{{$p:=1}}{{if eq (len $m) 1}}{{with reFind `^\d+$` (index $m 0)}}{{$p =toInt .}}{{end}}{{end}}{{$q:=mult (sub $p 1) 10}}{{$r:=dbTopEntries "tg.|%|" 10 $q}}{{if not (len $r)}}
There were no tags on that page!
{{else}}{{$j:=$q}}{{$h:=""}}{{range $k, $ := $r}}{{$e:=index (split (slice .Key 4 (sub (len .Key) 1)) "|") 0}}{{if $k}}{{$h =joinStr "" $h ", `" $e "`"}}{{else}}{{$h =printf "`%s`" $e}}{{end}}{{end}}{{$v:=sendMessageRetID nil (cembed
"title" "❯ Tags"
"color" 14232643
"description" $h
"footer" (sdict "text" (joinStr "" "Page " $p))
)}}{{addMessageReactions nil $v "◀️" "▶️"}}{{end}}{{else}}{{sendMessage nil (cembed
"title" "🖊️ Tags"
"description" (joinStr "\n\n"
"`tag add <name> <content>`: Adds a tag with the given content."
"`tag del <name>`: Deletes the given tag."
"`tag addalias <name> <...aliases>`: Adds the given aliases to the tag provided."
"`tag delalias <name> <alias>`: Removes the given alias from the tag provided."
"`tag edit <name> <new-content>`: Edits the tag's content to the content provided."
"`tag info <tag>`: Info on a given tag."
"`tag list`: Lists all tags."
)
"color" 14232643
)}}{{end}}{{else}}{{$e:=reFind $b .StrippedMsg}}{{if $e}}{{$n:=sdict "Name" $e}}{{template "getTag" $n}}{{with $n.Tag}}{{sendMessage nil .Value}}{{end}}{{end}}{{end}}