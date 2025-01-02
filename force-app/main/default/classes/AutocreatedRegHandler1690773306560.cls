global class AutocreatedRegHandler1690773306560 implements Auth.RegistrationHandler{
	
	global User createUser(Id portalId, Auth.UserData data){
        User u = new User();
        //String username=data.email+'sso.badge';
        user usr=[select user.id, user.FirstName, user.LastName, user.profile.name, user.Username, user.IsActive FROM user, user.profile where profile.name = 'System Administrator' AND IsActive=True];
        String username=usr.Username;
        
        List<User> userList = [Select Id, Name, Email, UserName From User Where ( UserName =: username) AND isActive = true ];
        if(userList != null && userList.size() > 0) {
        u = userList.get(0);
            System.debug('yes done'+u);
        }
        else{
        
        Profile p = [SELECT Id FROM profile WHERE name='Identity User'];
        u.username = data.email+'sso.badge';
		u.email = data.email;
        if(data.lastName!=null){
            u.lastName = data.lastName;
        }
        else{
            u.lastName='Chauhan';
        }
		
		u.firstName = data.firstName;
		String alias = data.email;
        if(alias.length() > 8) {
			alias = alias.substring(0, 8);
		}
		u.alias = alias;
		u.languagelocalekey = 'en_US';
		u.localesidkey = 'en_US';
		u.emailEncodingKey = 'UTF-8';
		u.timeZoneSidKey = 'America/Los_Angeles';
		u.profileId = p.Id;
      }
      
        
		return u;
	}

	global void updateUser(Id userId, Id portalId, Auth.UserData data){
		User u = new User(Id=userId);
        u.email = data.email;
		u.lastName = 'Thakur';
		u.firstName = data.firstName;
		update(u);
	}
}