{{/* 
    This Will Delete The Balance of The User That is Leaving 

    Put This In The user Leave Message Notification

*/}}

{{ dbDel .User.ID "HAND" }}
{{ dbDel .User.ID "NETWORTH" }}
{{ dbDel .User.ID "GBANK" }}
{{/* Your Leave Message*/}}