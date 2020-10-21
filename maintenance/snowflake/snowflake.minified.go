{{$a:=(parseArgs 1 "**Syntax:** -snowflake <snowflake>" (carg "int" "snowflake")).Get 0}}{{$b:=div $a 4194304 | add 1420070400000 | mult 1000000 | toDuration | (newDate 1970 1 1 0 0 0).Add}}

**❯ Timestamp:** `{{$b}}`
**❯ Formatted:** {{$b.Format "Jan 02, 2006 3:04 AM"}}
