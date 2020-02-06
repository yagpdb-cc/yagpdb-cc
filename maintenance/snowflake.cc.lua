{{ $epoch := 1420070400000 }}
{{ $snowflake := (parseArgs 1 "**Syntax:** -snowflake <snowflake>" (carg "int" "snowflake")).Get 0 }}
{{ $timestamp := add (toInt (div $snowflake 4194304)) $epoch }}
{{ $generated := (newDate 1970 1 1 0 0 0).Add (toDuration (mult $timestamp 1000000) ) }}
**❯ Timestamp:** `{{ $generated }}`
**❯ Formatted:** {{ $generated.Format "Jan 02, 2006 3:04 AM" }}