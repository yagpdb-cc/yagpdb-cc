{{- /*
	This command makes YAGPDB choose a given item from the ones provided. Usage: `-choose <...items>`.

	Recommended trigger: Command trigger with trigger `choose`.
*/ -}}

{{ if .CmdArgs }}
	{{ .User.Mention }}, I choose **{{ index .CmdArgs (randInt (len .CmdArgs)) }}**!
{{ else }}
	Please provide some items for me to choose: for example, `-choose "go to sleep" "stay awake" no`.
{{ end }}