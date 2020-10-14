{{/* 
    This Will Delete The Balance of The User That is Leaving 

    Put This In The user Leave Message Notification

*/}}

{{/*CONFIGURATION START*/}}
{{$handName := "HAND"}}{{/*Database name of the in hand money balance*/}}
{{$bankName := "GBANK"}} {{/*Database name of the bank money balance*/}}
{{$networthName := "NETWORTH"}}{{/*Database name of the networth money balance*/}}
{{/*CONFIGURATION END*/}}

{{ dbDel .User.ID $handName }}
{{ dbDel .User.ID $bankName }}
{{ dbDel .User.ID $networthName }}
{{/* Your Leave Message*/}}
