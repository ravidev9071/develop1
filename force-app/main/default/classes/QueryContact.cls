public class QueryContact {
    public static Id getContactID(String lastName, String title) {
        try {
            Contact myContact = Database.query(
                'SELECT ID FROM Contact WHERE lastName = :lastName AND title = :title LIMIT 1'
            );
            return myContact.Id;
        } catch (Exception ex) {
            return null;
        }
    }
    public static Id getContactIDWithBinds(Map<String, Object> bindVars) {
        String query = 'SELECT ID FROM Contact WHERE LastName = :lastName AND Title = :title LIMIT 1';
        
        List<Contact> contacts = Database.queryWithBinds(query, bindVars, AccessLevel.USER_MODE);
        
        if (contacts != null && !contacts.isEmpty()) {
            
            return contacts[0].Id;
            
        } else {
            
            return null;
            
        }
        
    }
}