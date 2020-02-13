{{/*
	This command calculates the timestamp of a Discord snowflake.

	Recommended trigger: Command trigger with trigger `snowflake`.
*/}}

{{ $snowflake := (parseArgs 1 "**Syntax:** -snowflake <snowflake>" (carg "int" "snowflake")).Get 0 }}

{{/* Logic: Divide snowflake by 2 to the 22nd, add it to Discord epoch, multiply by 1 million to convert to nano, convert to duration, add to Unix epoch */}}
{{ $timestamp := div $snowflake 4194304 | add 1420070400000 | mult 1000000 | toDuration | (newDate 1970 1 1 0 0 0).Add }}

**❯ Timestamp:** `{{ $timestamp }}`
**❯ Formatted:** {{ $timestamp.Format "Jan 02, 2006 3:04 AM" }}