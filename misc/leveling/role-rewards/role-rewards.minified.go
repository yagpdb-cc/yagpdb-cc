{{$d:=cembed
"title" "🏆 Role Rewards"
"description" (joinStr "\n\n"
"`rolerewards add <level> <role>`: Adds a role reward at the given level"
"`rolerewards remove <level>`: Removes the role reward from the given level"
"`rolerewards set-type <highest|stack>`: Sets the role reward type. Highest means only the highest role reward less than or equal to the current level, stack is all role rewards up to that level."
"`rolerewards reset`: Resets role reward settings."
"`rolerewards view`: Views current settings for role rewards."
)
"color" 14232643}}{{if .CmdArgs}}{{$a:=sdict "type" "stack"}}{{with (dbGet 0 "roleRewards")}}{{$a =sdict .Value}}{{end}}{{$i:=index .CmdArgs 0}}{{if and (eq $i "add") (ge (len .CmdArgs) 3)}}{{$e:=index .CmdArgs 1 | toInt}}{{$f:=slice .CmdArgs 2 | joinStr " " | lower}}{{$b:=0}}{{$c:=0}}{{with reFindAllSubmatches `^<@&(\d{17,19})>|(\d{17,19})$` $f}}{{$k:=toInt (or (index . 0 1) (index . 0 2))}}{{range $.Guild.Roles}}{{if eq .ID $k}}{{$b =.}}{{end}}{{end}}{{else}}{{range .Guild.Roles}}{{if eq (lower .Name) (lower $f)}}{{$b =.}}{{else if inFold (lower .Name) (lower $f)}}{{$c =.}}{{end}}{{end}}{{end}}{{$g:=or $b $c}}{{if and $e $g}}{{if and (ge $e 1) (le $e 200)}}{{$a.Set (str $e) $g.ID}}{{$l:=dbSet 0 "roleRewards" $a}} 
Successfully set the role `{{$g.Name}}` to be given at the level `{{$e}}`.
{{else}}
Sorry, the level provided was not in the range 1-200.
{{end}}{{else}}
Sorry, I was unable to find the role you provided / the level provided was invalid.
{{end}}{{else if and (eq $i "set-type") (ge (len .CmdArgs) 2)}}{{$h:=index .CmdArgs 1}}{{if not (in (cslice "stack" "highest") $h)}} 
Sorry, that was not a valid type. The type must be either "stack" or "highest".
{{else}}{{$a.Set "type" $h}}{{$l:=dbSet 0 "roleRewards" $a}} 
Successfully set the role-giving type of this server to `{{$h}}`.
{{end}}{{else if eq $i "reset"}}{{$l:=dbSet 0 "roleRewards" (sdict "type" "stack")}} 
Alright, I cleared the role rewards for this server!

{{else if and (eq $i "remove") (ge (len .CmdArgs) 2)}}{{with (reFind `\d+` (index .CmdArgs 1))}}{{if $a.Get .}}{{$a.Del .}}{{$l:=dbSet 0 "roleRewards" $a}}
Successfully removed the role reward from the level `{{.}}`.
{{else}}
Sorry, there is not a role reward set for that level!
{{end}}{{else}}
Please provide a valid level to remove the role reward from.
{{end}}{{else if eq $i "view"}}{{if eq (len $a) 1}}{{sendMessage nil (cembed "title" "Role Rewards" "thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png") "description" (joinStr "" "**❯ Role Rewards:** n/a\n**❯ Type:** " $a.type))}}{{else}}{{$j:=""}}{{range $e:=seq 1 201}}{{with ($a.Get (str $e))}}{{$j =printf "%s\n❯ **Level %d:** <@&%d>" $j $e .}}{{end}}{{end}}{{sendMessage nil (cembed "title" "Role Rewards" "thumbnail" (sdict "url" "https://i.imgur.com/mJ7zu6k.png") "description" (joinStr "" $j "\n\n" "**❯ Type:** " $a.type))}}{{end}}{{else}}{{sendMessage nil $d}}{{end}}{{else}}{{sendMessage nil $d}}{{end}}
