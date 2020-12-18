# Case_System 

This a cases system similar to the one in Unbelievaboat bot but with extra features and the added advantage of being able to customize it 

# Functionality

This is not a stand alone custom command and you will need to add all the commands for the system to work properly 
There is a leading Comment in every code showing the description and the trigger of the cc

You have to create a command override for `ban,kick,mute and warn` with the setting of auto deleting the trigger after 0 or 1 sec to prevent YAGPDB from posting the warned message twice

# Note:
If you are customizing the code "do not" remove the userID from the author field of the `-cases <user>` command as it will cause problems and won't work as expected  
