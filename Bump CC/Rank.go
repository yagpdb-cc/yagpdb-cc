{{/* 
    Trigger Regex
      `!d (rank|lvl)
*/}}

{{execAdmin "clean" 1}} {{/*Optional, to clean Disboard's Message*/}}
{{$s := (dbGet .User.ID "BumpXP").Value}}
Your Level is {{$s}}
