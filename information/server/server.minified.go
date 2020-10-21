{{$f:=""}}{{$g:=printf "%s (%d)" .Guild.Name .Guild.ID}}{{if .Guild.Icon}}{{$f =printf "https://cdn.discordapp.com/icons/%d/%s.webp" .Guild.ID .Guild.Icon}}{{end}}{{$e:=userArg .Guild.OwnerID}}{{$d:=cslice
"None: Unrestricted"
"Low: Must have a verified email on their Discord account."
"Medium: Must also be a member of this server for longer than 10 minutes."
"(╯°□°）╯︵ ┻━┻: Must also be a member of this server for longer than 10 minutes."
"┻━┻ ﾐヽ(ಠ益ಠ)ノ彡┻━┻: Must have a verified phone on their Discord account."}}{{$h:="n/a"}}{{if .Guild.AfkChannelID}}{{$h =printf "**Channel:** <#%d> (%d)\n**Timeout:** %s"
.Guild.AfkChannelID
.Guild.AfkChannelID
(humanizeDurationSeconds (toDuration (mult .Guild.AfkTimeout .TimeSecond)))}}{{end}}{{$a:="No"}}{{if .Guild.EmbedEnabled}}{{$a ="Yes"}}{{end}}{{$b:=div .Guild.ID 4194304 | add 1420070400000 | mult 1000000 | toDuration | (newDate 1970 1 1 0 0 0).Add}}{{$c:=cembed
"author" (sdict "name" $g "icon_url" $f)
"color" 14232643
"thumbnail" (sdict "url" $f)
"fields" (cslice
(sdict "name" "❯ Verification Level" "value" (index $d .Guild.VerificationLevel))
(sdict "name" "❯ Region" "value" .Guild.Region)
(sdict "name" "❯ Members" "value" (printf "**• Total:** %d Members\n**• Online:** %d Members" .Guild.MemberCount onlineCount))
(sdict "name" "❯ Roles" "value" (printf "**• Total:** %d\nUse `-listroles` to list all roles." (len .Guild.Roles)))
(sdict "name" "❯ Owner" "value" (printf "%s (%d)" $e.String $e.ID))
(sdict "name" "❯ AFK" "value" $h)
(sdict "name" "❯ Embeds Enabled" "value" $a)
)
"footer" (sdict "text" "Created at")
"timestamp" $b}}{{if .CmdArgs}}{{if eq (index .CmdArgs 0) "icon"}}{{sendMessage nil (cembed
"author" (sdict "name" $g "icon_url" $f)
"title" "❯ Server Icon"
"color" 14232643
"image" (sdict "url" $f)
)}}{{else}}{{sendMessage nil $c}}{{end}}{{else}}{{sendMessage nil $c}}{{end}}
