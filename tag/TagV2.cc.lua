{{/* YOU WILL HAVE TO DELETE THIS COMMENT FOR THE COMMAND TO WORK
	Made by Joe_#0001 and Crenshaw#1312
	This command manages the tag system.
	Changes: Syntax
			 better color (indigo)
			 new `;tag list` appearence
			 RoleFilterilter on tag management
			 Response is now an embed
			 Each sub command has more options
	Usage: 

	`;tag add/create <name> <value>`
	`;tag del/delete/remove <name>`
	`;tag (add/create)alias(es) <name> <...aliases>`
	`;tag (del/delete/remove)alias(es) <name> <alias>`
	`;tag list/show/all`
	`;tag info/information/about <name>`
	`;tag syntax
	`;<tag>` (i.e say you have tag with name `foobar`, `;foobar` would view that tag)

	Recommended trigger: StartsWith trigger with trigger `;`.
*/}}
{{/*CONFUGURATION VALUES START*/}}
{{$tagCreator:=cslice 770291866208829470}}{{/*ROLES allowed to manage tags*/}}
{{/*CONFIGURATION VALUES END*/}}

{{$isCreator:=false}}
{{range .Member.Roles}} {{if in $tagCreator .}}{{$isCreator = true}}{{end}}{{end}} 
 
{{$isCmd:=reFind "^tags? *" .StrippedMsg}}
{{$safeName:=`^[^\|_%<>/]{1,25}$`}}
 
{{define "getTag"}}
	{{$tagName:=lower .Name}}
	{{$tag:=0}}
	{{$entries:=dbTopEntries (printf "tg.%%|%s|%%" $tagName) 1 0}}
	{{if len $entries}} 
		{{$tag =index $entries 0}}
		{{.Set "Aliases" (joinStr "/" (split (slice $tag.Key 4 (sub (len $tag.Key) 1)) "|"))}}
	{{end}}
	{{.Set "Tag" $tag}}
{{end}}
 
{{if $isCmd}}
	{{$cmd := ""}}
	{{$args := cslice}}
	{{if gt (len .CmdArgs) 1}}{{ $cmd =index .CmdArgs 1}}{{end}}
	{{if gt (len .CmdArgs ) 2}}{{ $args =slice .CmdArgs 2}}{{end}}
 
	{{if and $isCreator (reFind `(add|create)$` $cmd) (ge (len $args) 2)}}
		{{$tagName:=index $args 0 | lower}}
		{{$tagContent:=slice $args 1 | joinStr " "}}
		{{if reFind $safeName $tagName}}
			{{$data := sdict "Name" $tagName}}
			{{template "getTag" $data}}
			{{if not $data.Tag}}
				{{dbSet 0 (printf "tg.|%s|" $tagName) $tagContent}}
				Successfully added a tag with the name `{{$tagName}}`.
			{{else}}
				That tag already exists.
			{{end}}
		{{else}}
			Tag names must not contain the `|`, `_`, `<`, `>`, `/`, or `%` character and be under 25 characters!
		{{end}}
 
	{{else if and $isCreator (reFind `(del(ete)?|remove)$` $cmd) (len $args)}}
		{{$toDelete:=joinStr " " $args}}
		{{$data:=sdict "Name" $toDelete}}
		{{template "getTag" $data}}
		{{with $data.Tag}}
			{{dbDelByID .UserID .ID}}
			Successfully deleted the tag `{{index (split (slice .Key 4 (sub (len .Key) 1)) "|") 0}}`!
		{{else}}
			Sorry, that tag does not exist.
		{{end}}
 
	{{else if and (reFind `(info(romation)?|about)` $cmd) (len $args)}}
		{{$tagName := joinStr " " $args}}
		{{$data:=sdict "Name" $tagName}}
		{{template "getTag" $data}}
		{{with $data.Tag}}
			{{$aliases := split $data.Aliases "/"}}
			{{$list := ""}}
			{{if ge (len $aliases) 2}}
				{{- range $k, $:=slice $aliases 1 -}}
					{{if $k}}
						{{$list =joinStr "" $list ", `" . "`"}}
					{{else if .}}
						{{$list =printf "`%s`" .}}
					{{end}}
				{{end}}
			{{end}}
			{{sendMessage nil (cembed
				"title" "❯ Tag Info"
				"color" 14232643
				"fields" (cslice
					(sdict "name" "❯ Name" "value" (index $aliases 0))
					(sdict "name" "❯ Aliases" "value" (or $list "n/a"))
					(sdict "name" "❯ Created At" "value" (.CreatedAt.Format "Jan 02, 2006 3:04 PM"))
				)
				"footer" (sdict "text" (print "Requested by " $.User.Username) "icon_url" ($.User.AvatarURL "256"))
			) }}
		{{else}}
			That tag does not exist. Try again?
		{{end}}
 
	{{else if and $isCreator (reFind `(edit|alter)` $cmd ) (ge (len $args) 2)}}
		{{$tagName:=index $args 0}}
		{{$tagContent:=slice $args 1|joinStr " "}}
		{{if reFind $safeName $tagName}}
			{{$data:=sdict "Name" $tagName}}
			{{template "getTag" $data}}
			{{with $data.Tag}}
				{{dbSet 0 .Key $tagContent}}
				Successfully edited the content of the tag `{{ $tagName }}`.
			{{else}}
				Sorry, that tag does not exist!
			{{end}}
		{{else}}
			That tag does not exist!
		{{end}}
 
	{{else if and $isCreator (reFind `addalias(es)?` $cmd) (ge (len $args) 2)}}
		{{$tagName:=index $args 0}}
		{{$aliases:=slice $args 1 }}
		{{$valid:=true }}
		{{$key:=printf "tg.|%s|" $tagName }}
		{{- range $k, $:=$aliases -}}
			{{if not (reFind $safeName .)}}
				{{$valid = false}}
			{{else if $k}}
				{{$key = joinStr "" $key "|" (lower .)}}
			{{else}}
				{{$key = joinStr "" $key (lower .)}}
			{{end}}
		{{end}}
		{{if and (reFind $safeName $tagName) $valid}}
			{{$data:=sdict "Name" $tagName}}
			{{template "getTag" $data}}
			{{with $data.Tag}}
				{{dbDelByID .UserID .ID}}
				{{$newKey:=joinStr "" $key "|"}}
				{{if gt (len $newKey) 256}}
					Sorry, that alias was too long. Try again.
				{{else}}
					{{dbSet 0 (joinStr "" $key "|") .Value}}
					Successfully added {{len $aliases}} aliases to the tag `{{$tagName}}`!
				{{end}}
			{{else}}
				Sorry, that tag does not exist.
			{{end}}
		{{else}}
			Sorry, some aliases provided were not valid! Try again.
		{{end}}
 
	{{else if and $isCreator (reFind `(del(ete)?|remove)alias(es)?` $cmd) (ge (len $args) 2)}}
		{{$tagName:=index $args 0}}
		{{$toRemove:=slice $args 1 | joinStr " "|lower}}
		{{$data := sdict "Name" $tagName}}
		{{template "getTag" $data}}
		{{with $data.Tag}}
			{{$aliases:=split $data.Aliases "/"}}
			{{$tagName:=printf "tg."}}
			{{if eq (len $aliases) 1}}
				Sorry, you cannot remove an alias from a tag with only 1 alias.
			{{else}}
				{{range $aliases}}
					{{if ne $toRemove .}}
						{{$tagName = joinStr "" $tagName "|" .}}
					{{ end }}
				{{end}}
				{{$tagName =joinStr "" $tagName "|"}}
				{{dbDelByID .UserID .ID}}
				{{dbSet 0 $tagName .Value}}
				Successfully removed alias!
			{{end}}
		{{else}}
			That tag does not exist.
		{{end}}
 
	{{else if reFind `list|show|all` $cmd}}
		{{$page:=1}}
		{{if eq (len $args) 1}}{{with reFind `^\d+$` (index $args 0)}}{{ $page =toInt .}}{{end}}{{end}}
		{{$skip:=mult (sub $page 1) 10}}
		{{$tags:=dbTopEntries "tg.|%|" 10 $skip}}
		{{if not (len $tags)}}
			There were no tags, go make some!
		{{else}}
			{{$display:=""}}
			{{$total:=len $tags}}
			{{- range $k, $:=$tags -}}
				{{$tagName:=title (index (split (slice .Key 4 (sub (len .Key) 1)) "|") 0)}}
				{{$tagIndex:=add $skip $k 1}}
				{{$tagDate:=.CreatedAt.Format "Jan 02 3:04 PM"}}
				{{$tagLine:=print "#" $tagIndex "-" $tagName " " (joinStr ", " (split (slice .Key 4 (sub (len .Key) 1)) "|")) " [" $tagDate "]\n\n"}}
				{{if eq $k (sub $total 1)}}
					{{$display =print $display $tagLine "```\n For more results: `-tag list <page num>`"}}
				{{else if $k}}
					{{$display =print $display $tagLine}}
				{{else}}
					{{$display =print "```css\n" $tagLine}}
				{{end}}
			{{end}}
			{{sendMessage nil (cembed
				"title" "❯ Tags"
				"color" 0x4B0082
				"description" $display
				"footer" (sdict "text" (print "Requested by " .User.Username) "icon_url" (.User.AvatarURL "256"))
			) }}
		{{end}}
 
	{{else if eq $cmd "syntax"}}
		{{$id:=sendMessageRetID nil (cembed
			"title" "❯ Syntax"
			"color" 0x4B0082
			"description" (joinStr "\n"
				"**USER**"
				(print "`{{User-String}}`: User's name **" .User.String "**")
				(print "`{{User-Username}}`: User's username **" .User.Username "**")
				(print "`{{User-Discrminator}}`: 4 digits after username **" .User.Discriminator "**")
				(print "`{{User-ID}}`: User's ID **" .User.ID "**")
				(print "`{{User-Age}}`: User's age **" currentUserAgeHuman "**")
				(print "`{{User-Mention}}`:Mentions triggering user " .User.Mention)
				"**CHANNEL**"
				(print "`{{Channel-Name}}`: Channel name of channel **" .Channel.Name "**" )
				(print "`{{Channel-Topic}}`: Channel topic **" (print .Channel.Topic " ") "**")
				(print "`{{Channel-ID}}`: Channel ID of trggering channel **" .Channel.ID "**\n")
			)
			"footer" (sdict "text" (print "Requested by " $.User.Username) "icon_url" ($.User.AvatarURL "256"))
		) }}
	{{else}}
		{{$id := sendMessageRetID nil (cembed
			"title" "🖊️ Tags"
			"description" (joinStr "\n\n"
				"`tag add <name> <content>`: Adds a tag with the given content."
				"`tag del <name>`: Deletes the given tag."
				"`tag addalias <name> <...aliases>`: Adds the given aliases to the tag provided."
				"`tag delalias <name> <alias>`: Removes the given alias from the tag provided."
				"`tag edit <name> <new-content>`: Edits the tag's content to the content provided."
				"`tag info <tag>`: Info on a given tag."
				"`tag list`: Lists all tags."
				"`tag syntax`: List of available syntax."
			)
			"footer" (sdict "text" (print "Requested by " $.User.Username) "icon_url" ($.User.AvatarURL "256"))
			"color" 0x4B0082
		) }}
		{{deleteMessage nil $id 25}}
	{{end}}
{{else if and ($isCmd) (not $isCreator)}}
	{{sendMessage nil "This command can only be used by admin/mod" }}
{{else}}
	{{$syntax:=sdict 
			"user" (sdict "age" currentUserAgeHuman "string" .User.String "username" .User.Username "discriminator" .User.Discriminator "id" (toString .User.ID) "nickname" .Member.Nick ) 
			"channel" (sdict "name" .Channel.Name "id" (toString .Channel.ID) "topic" .Channel.Topic)
	 }}
	{{$tagName:=reFind $safeName .StrippedMsg}}
	{{if $tagName}}
		{{$data:=sdict "Name" $tagName}}
		{{template "getTag" $data}}
		{{with $data.Tag}}
			{{$tagValue := .Value}}
			{{$tagSyntaxFound := reFindAll `(?i)\{\{\s?(channel|user)\s?-\s?([^\}]+)\}\}` $tagValue}}
			{{- range $tagSyntaxFound -}}
				{{ $split:=split (reReplace `(\{\{|\}\})` . "") "-" }}
				{{$result:=($syntax.Get (lower (index $split 0))).Get (lower (index $split 1))}}
				{{if $result}}{{$tagValue =reReplace . $tagValue $result}}{{end}}
			{{- end -}}
			{{sendMessage nil (cembed
				"title" (title (print "**" $data.Aliases "**"))
				"description" $tagValue
				"footer" (sdict "text" (print "Requested by " $.User.Username) "icon_url" ($.User.AvatarURL "256"))
				"color" 0x4B0082
			) }}
		{{end}}
	{{end}}
{{end}}
