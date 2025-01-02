public with sharing class githubhandledata {
public class test{
    public String id { get; set; }
    public String name { get; set; }
    public String description;
    public String language;
    public String default_branch;
    public String full_name;
    public githubhandledata.Owner owner;
    
}

    
    public class Owner{
        public String login;
    }
    
}