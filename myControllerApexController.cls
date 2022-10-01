public class myController {

    public list<booklist__c> booklist {get;set;}
    public string school{get;set;}
    public string grade{get;set;}
     public string email{get;set;}
    
    public Integer countTotalRecords{get;set;}
    public Integer offSetSize = 0;
    public Integer QueryLimit = 10;
    
public booklist__c control{get;set;}

public string SelectedAccountId { get; set; }
 
public myController() {
 
control = new booklist__c();
 //booklist = new List<booklist__c>();
 //countTotalRecords = [SELECT count() FROM booklist__c];
}



public void searchdata(){
    booklist = NULL;
    school  = '%'+ school +'%';
    
    if(NULL != school && school != '' && NULL != grade){
         booklist = [select id,fb_name__c, school__c,grade__c, phone_number__c, location__c from booklist__c where school__c like  :school  and grade__c like :grade];
    }else if (NULL != school && school != ''){
         booklist = [select  id,fb_name__c, school__c,grade__c, phone_number__c, location__c from booklist__c where school__c like :school ];
        
    }else if (NULL != grade){
         booklist = [select  id,fb_name__c, school__c,grade__c, phone_number__c, location__c from booklist__c where grade__c like :grade];
        
    }else{
         booklist = [select  id,fb_name__c, school__c,grade__c, phone_number__c, location__c from booklist__c];
        
    }
   
    if(booklist != NULL && booklist.size() != 0) {
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Displaying search results..')); 
    } else {
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'No Results Found..')); 
    }
}

public void searchdataEdit(){
    booklist = NULL;
    
    
    if (NULL != email && email != ''){
         booklist = [select  id,fb_name__c, school__c,grade__c, phone_number__c, location__c from booklist__c where email__c like :email];
         
         if(booklist != NULL && booklist.size() != 0) {
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Displaying Book Listings..')); 
    } else {
        ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'No Bookings Found for given Email..')); 
    }
        
    }else{
         ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Enter email id..')); 
        
    }
   
    
}

public List<SelectOption> getfixedVals(){
    List<SelectOption> stomps = new List<SelectOption>();
    stomps.add(new SelectOption('Grade 1','Grade 1'));
    stomps.add(new SelectOption('Grade 2','Grade 2'));
    stomps.add(new SelectOption('Grade 3','Grade 3'));
    
    stomps.add(new SelectOption('Grade 4','Grade 4'));
    stomps.add(new SelectOption('Grade 5','Grade 5'));
    stomps.add(new SelectOption('Grade 6','Grade 6'));
    
    stomps.add(new SelectOption('Grade 7','Grade 7'));
    stomps.add(new SelectOption('Grade 8','Grade 8'));
    stomps.add(new SelectOption('Grade 9','Grade 9'));
    stomps.add(new SelectOption('Grade 10','Grade 10'));
    stomps.add(new SelectOption('Grade 11','Grade 11'));
    stomps.add(new SelectOption('Grade 12','Grade 12'));
    

    return stomps;

}
 
public void submit() {
try {
control.Name = control.FB_NAME__c;
    if(control.Name!=NULL) {
       insert control;
       control = control = new booklist__c();
    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Infomation Saved successfully')); 
} else {
    ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'Please Enter the First Name')); 
}
} catch(Exception e) {
System.debug('-----Exception -----' + e);
ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR,'System Error : Incorret / Incomplete Data')); 
 }
 
}

public void DeleteAccount()
{
// if for any reason we are missing the reference
if (SelectedAccountId == null) {

return;
}

// find the account record within the collection
booklist__c tobeDeleted = null;
for(booklist__c a : booklist)
if (a.Id == SelectedAccountId) {
tobeDeleted = a;
break;
}

//if account record found delete it
if (tobeDeleted != null) {
Delete tobeDeleted;

ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.INFO,'Book Removed from Listing'));
searchdataEdit();
}
}


 public boolean getprv(){
        if(offSetSize > 0)
            return false;
        else
            return true;
    }
    
    public boolean getnxt(){
        if(offSetSize + queryLimit < CountTotalRecords)
            return false;
        else
            return true;
    }
    
    public PageReference nextbtn(){
        offSetSize += queryLimit ;
        return null;
    }
    
    public PageReference prvbtn(){
        offSetSize -= queryLimit ;
        return null;
    }
    
    public PageReference fstbtn(){
        offSetSize = 0;
        return null;
    }
    
    public PageReference endbtn(){
        offSetSize = countTotalRecords - math.mod(countTotalRecords,queryLimit);
        return null;
    }  

}