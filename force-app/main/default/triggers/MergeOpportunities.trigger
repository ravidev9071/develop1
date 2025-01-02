trigger MergeOpportunities on Opportunity (after insert) {
    // Collect the Account Id and Stage values of the new Opportunities
    Set<String> accountIds = new Set<String>();
    Set<String> stages = new Set<String>();
    
    for (Opportunity opp : Trigger.new) {
        accountIds.add(opp.AccountId);
        stages.add(opp.StageName);
    }
    
    // Query for existing Opportunities with the same Account and Stage values
    List<Opportunity> existingOpportunities = [
        SELECT Id, AccountId, StageName,Amount
        FROM Opportunity
        WHERE AccountId IN :accountIds
        AND StageName IN :stages
    ];
    
    Map<String, Opportunity> existingOpportunityMap = new Map<String, Opportunity>();
    
    // Create a map of existing Opportunities using a composite key of AccountId and StageName
    for (Opportunity opp : existingOpportunities) {
        String key = opp.AccountId + '-' + opp.StageName;
        existingOpportunityMap.put(key, opp);
    }
    
    List<Opportunity> opportunitiesToMerge = new List<Opportunity>();
    
    // Iterate over the new Opportunities and check if there are duplicates to merge
    for (Opportunity opp : Trigger.new) {
        String key = opp.AccountId + '-' + opp.StageName;
        
        // If a duplicate Opportunity is found, add it to the list for merging
        if (existingOpportunityMap.containsKey(key)) {
            Opportunity existingOpp = existingOpportunityMap.get(key);
            existingOpp.Amount += opp.Amount;
            
            opportunitiesToMerge.add(existingOpp);
        }
    }
    
    // Update the merged Opportunities
    update opportunitiesToMerge;
}