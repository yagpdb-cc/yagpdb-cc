# Commands

 1. **Suggest -**
 
	Syntax : `suggest <Suggestion Here>`
  
	Use : Creates a new Suggestion
		 
 2. **DeleteSuggest -**
 
	Syntax : `deletesuggest <Suggestion ID>`
  
	Use : Delete your own suggestions. Can be used to mods to silently delete/remove suggestions.	
		
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
