public class KnowledgeArticleHelper {
    public static void getKnowledgeFields() {
        try {
            // Query the Knowledge__kav object for specific fields
            List<Knowledge__kav> knowledgeArticles = [
                SELECT Id, Title, CreatedDate 
                FROM Knowledge__kav
                WHERE PublishStatus = 'Draft' AND Language = 'en_US'
                ORDER BY CreatedDate DESC
            ];
            
            // Loop through the results and log field values
            for (Knowledge__kav article : knowledgeArticles) {
                System.debug('Article Title: ' + article.Title);
                System.debug('Created Date: ' + article.CreatedDate);
            }
        } catch (Exception e) {
            System.debug('Error: ' + e.getMessage());
        }
    }
}