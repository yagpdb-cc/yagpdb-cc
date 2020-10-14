{{/*
	This code is supposed to be put in the leave feed. It removes the AFK messages of users who have left the server.
	It is optional, meaning that the other CCs in this system will work fine without it.
*/}}

{{ dbDel .User.ID "afk" }}
{{/* If you already have a leave message, you can put it here. */}}