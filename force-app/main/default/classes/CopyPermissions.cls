/**********************************************************************
 Name: CopyPermissions
 Other classes used: 
 Tested in class: 
======================================================
Description: 
    Controller for Permissions Tool
======================================================
History                                                            
-------                                                            
VERSION         AUTHOR                  DATE            DETAIL                                 
***********************************************************************/
public without sharing class CopyPermissions {

    public PageReference Log() {
    
    PageReference page = Page.PermissionsLog;
page.getParameters().put('emaillist', emaillist);
page.getParameters().put('allstring', allstring);
//page.setRedirect(true);
        return page;
    }


    public String emaillistgr { get; set; }

    public String allstring { get; set;}

    public String emaillistg { get; set; }

    public String emaillist { get; set; }
    public String emaillistl { get; set; }

    public List<String> selectpermissions {get; set;}   
    public List<String> selectlicenses {get; set;}    
    public List<String> allemails {get; set;}
    public List<String> allemailsl {get; set;}
    public List<String> allemailsg {get; set;}
    public List<String> allemailsgr {get; set;}  
    public List<PermissionSetAssignment> nw2 {get; set;}
    public List<userpackagelicense> nw3 {get; set;}
    public List<Id> permissionsetids {get; set;}
    public List<Id> licenseselected {get; set;}

    public List<selectoption> getallpermissions() {
    List<SelectOption> options = new List<SelectOption>();
    for (permissionset p : [SELECT Name, label FROM PermissionSet WHERE IsOwnedByProfile =false order by Name])
     {
        options.add(new SelectOption(p.Name,p.label));       
     
     }    
     return options;
    }
    
        public List<selectoption> getallLicenses() {
    List<SelectOption> options = new List<SelectOption>();
    for (packagelicense l : [select namespaceprefix, id from packagelicense])
     {
        options.add(new SelectOption(l.namespaceprefix,l.namespaceprefix));       
     
     }    
     return options;
    }


    public String UserId { get; set; }
    public String CurrentUserId {get; set;}
    public List<PermissionSetAssignment> Existing {get; set;}
    
    public PageReference Copy() {
    
      if(Test.isRunningTest()){
        UserId = [select id from user where firstname = 'Saumitra' LIMIT 1].id;
        CurrentUserId = [select id from user where firstname = 'Saumitra' LIMIT 1].id;
        selectpermissions = new List<string>();
        selectpermissions.add('Infosys_Support_Team');
        selectlicenses = new List<string>();
        selectlicenses.add('Infosys_Support_Team');
        emaillist = [select id, username from user where firstname = 'Saumitra' LIMIT 1].username;
        emaillistl = [select id, username from user where firstname = 'Saumitra' LIMIT 1].username;  
        emaillistgr = [select id, username from user where firstname = 'Saumitra' LIMIT 1].username;
        emaillistg = 'India';     
      
      }
      if(apexpages.currentpage().getparameters().get('id')!=null){
      CurrentUserId = apexpages.currentpage().getparameters().get('id').escapeECMAScript();//CR00038944
        }else{
        CurrentUserId = apexpages.currentpage().getparameters().get('id');//CR00038944
        }
      List<PermissionSetAssignment> nw = new List<PermissionSetAssignment>();
      set<Id> ExistingUserPermSet = new Set<Id>();
      for (PermissionSetAssignment temp1 : [select id, AssigneeId, PermissionSetId from PermissionSetAssignment where AssigneeId = :UserId AND PermissionSetId IN (SELECT Id FROM PermissionSet WHERE IsOwnedByProfile =false)])
      {
        PermissionSetAssignment psa = new PermissionSetAssignment();
        psa.AssigneeId = CurrentUserId;
        psa.PermissionSetId = temp1.PermissionSetId;
        nw.add(psa); 
      }

    Database.insert(nw, false);
         return null;     
        
    }
    
    
        public PageReference Assign() {
       allemails = emaillist.split(',');
       allstring = string.join(selectpermissions,',');
    nw2 = new List<PermissionSetAssignment>();

    permissionsetids = new List<Id>();
    for (permissionset abc : [select id from permissionset where name IN :selectpermissions])
    {
       permissionsetids.add(abc.id);
    }
  
    
    for(user usr : [select id from user where username IN :allemails])
    {
    
 
            
    for (Id p2 : permissionsetids)
      {
        PermissionSetAssignment psa2 = new PermissionSetAssignment();
        psa2.AssigneeId = usr.id;
        psa2.PermissionSetId = p2;
        nw2.add(psa2); 
           
      }
    
    Database.Insert(nw2, false);
  }
   
        return null;
    }
    
     public PageReference Assigngroups() {
    
    allemailsgr = emaillistgr.split(',');
    allemailsg = emaillistg.split(',');
    List<GroupMember> LGM = new List<GroupMember>();
    List<User> GroupUsr = [select id from user where username in : allemailsg];
    List<Group> GrId = [select id from group where name in : allemailsgr];
    for (Group grp : GrId)
    {
    
       for (user ug : GroupUsr)
       {
          GroupMember GM = new GroupMember();
          GM.UserOrGroupId = ug.id;
          GM.GroupId = grp.id;
          LGM.add(GM);       
       }
    
    }
    
    Database.insert(LGM, false);
        return null;
    }

 public PageReference AssignLicenses() {
allemailsl = emaillistl.split(',');
nw3 = new List<userpackagelicense>();
licenseselected = new List<Id>();
for(packagelicense pl: [select id from packagelicense where namespaceprefix IN : selectlicenses])
{
  licenseselected.add(pl.id);
}

for(user usr2 : [select id from user where username IN :allemailsl])
{

for (id ipl : licenseselected){
   userpackagelicense upl = new userpackagelicense();
   upl.PackageLicenseId = ipl;
   upl.UserId = usr2.id;
   nw3.add(upl);
   }
 Database.Insert(nw3, false);
}
    return null;
}
}