# Trigger 

### Type - Regex

### Trigger -

	(?i)\A(\-\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+((?:mark)?dupe|deny|implement(ed)?|archive|approved?|comment))(\s+|\z)

**Note:** If your prefix is not `-` replace the `-` at the start of the trigger with your prefix.

Example - For a server with prefix - `?`, Trigger would be : `(?i)\A(\?\s?|<@!?204255221017214977>\s*)((del(ete)?|edit)?suggest(ion)?|(sa|suggestadmin)\s+((?:mark)?dupe|deny|implement(ed)?|archive|approved?|comment))(\s+|\z)`


# Configuration Variables

1. `$Suggestion_Channel` -

	The channel where the suggestions are sent.

2. `$Logging_Channel` - 

	The channel where messages regarding denied/approved/implemented and suggestions marked as dupe are sent. It us suggested to keep it separate from the $Suggestion_Channe to reduce clutter but depends on personal taste. 

3. `$Implemented_Channel` -
	
	The channel where suggestions which have been marked as implemented are sent. This provides a good way to organise all implemnted suggestions into a separate channel.
	
4. `$Approved_Channel` -
	
	The channel where suggestions which have been marked as approved are sent. This provides a good way to organise all approved suggestions. This provides a good way to organise all implemnted suggestions into a separate channel. It is very much possible to set the same channel for tracking approved+implemented suggestions by using the same channel id in both variables.

*Note:* Among the **above** variables all channels can be separate or same. All combinations are possible. 

**IMPORTANT - DO NOT LEAVE ANY CHANNEL ID AS BLANK. YOU CAN PUT ALL IDS SAME BUT NEVER LEAVE THEM BLANK!!**

5. `$Mod_Roles` -

	List of all role ids of moderators who shpuld have access to all the suggestadmin commands. You do no need to specify roles who have `administrator` permissions in your server. They will have access by default.

6. `$Cooldown` -

	Colldown in seconds between consucutive suggestions. This prevents suggestion misuse/spam. Can be set to 0 to disable. Mods/Admins can bypass the cooldown.

7. `$Upvote` -

	The emoji for upvote reaction. Supports both custom as well as inbuilt emojis. For inbuilt emojis, it is recommended to use corresponding unicode characters. Example : "👍".
	
8. `$Downvote` -

	The emoji for downvote reaction. Supports both custom as well as inbuilt emojis. For inbuilt emojis, it is recommended to use corresponding unicode characters. Example : "👎".


# Commands

 1. **Suggest -**
 
	Syntax : `suggest <Suggestion Here>`
  
	Use : Creates a new Suggestion
		 
 2. **DeleteSuggest -**
 
	Syntax : `deletesuggest <Suggestion ID>`
  
	Use : Delete your own suggestions. Can be used by mods to silently delete/remove suggestions.	
		
 3. **EditSuggest -**
 
	Syntax : `editsuggest <Suggestion ID> <New Suggestion>`
  
	Use : Edits your previously posted suggestions.
	 
 4. **SA/SuggestAdmin commands -**
 
    - **Deny :** 
          
         Syntax: `sa deny <Suggestion ID> <Optional Reason>`
         
         Use: Denies a suggestion, deletes it and tags the original person who posted the suggestion with reason for denial.
	 
    - **Dupe :**
      
        Syntax: `sa dupe <Suggestion ID> <Original Suggestion ID>`
        
        Use: Marks a suggestion dupe of a previous suggestion, deletes it and informs the user who posted with a tag.
	 
    - **Approve :**
          
         Syntax: `sa approve <Suggestion ID> <Optional Comment>`
         
         Use: Marks a suggestion as approved by re-posting in approved suggestions channel. Also keeps a record as to who approved the suggestion in footer. Supports additional comments.
  
    - **Implement :**
          
         Syntax: `sa implement <Suggestion ID> <Optional Comment>`
         
         Use: Marks a suggestion as implemented by re-posting in implemented suggestions channel. Also keeps a record as to who implemented the suggestion in footer. Supports additional comments.
  

    - **Comment :**
          
         Syntax: `sa comment <Suggestion ID> <New Comment>`
         
         Use: Updates comment of a new/approved/implemented Suggestion.
  
    
*Note:* Precede all commands with @YAGPDB.xyz or prefix to trigger them
