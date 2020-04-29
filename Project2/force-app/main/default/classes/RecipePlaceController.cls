public class RecipePlaceController
{
    @AuraEnabled
    public static List<Map<String, String>> RecipeSearch(String dish, String ingredients)
    {
        List<Map<String, String>> resultsList = new List<Map<String, String>>();
        List<String> titleList = new List<String>();
        List<String> hrefList = new List<String>();
        List<String> ingredientsList = new List<String>();
        List<String> thumbnailList = new List<String>();
        
        String dishSearch = dish.deleteWhitespace();
        String ingredientsSearch = ingredients.deleteWhitespace();
        
        /* Get HTTP Response */
            
        Http http = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.recipepuppy.com/api/?q=' + dishSearch + '&i=' + ingredientsSearch + '&p=1');
        req.setMethod('GET');
        
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200)
        {
            /* Parse JSON Response into Lists */
            
            titleList = ParseByField(res, 'title');
            hrefList = ParseByField(res, 'href');
            ingredientsList = ParseByField(res, 'ingredients');
            thumbnailList = ParseByField(res, 'thumbnail');
            
            /* Create Recipe List from Parsed JSON Lists */
            
            resultsList = CreateRecipeList(titleList, hrefList, ingredientsList, thumbnailList);
        }
        else
        {
            System.debug('Status code was not 200. Status = ' + res.getStatusCode());
        }
        
        return resultsList;
    }
    
    @AuraEnabled
    public static void SaveRecipe(String pName, String pURL)
    {
        Recipe__c rec = new Recipe__c();
        rec.Name = pName;
        rec.URL__c = pURL;
        
        insert rec;
    }
    
    /* Creates Lists of Each Value */
    private static List<String> ParseByField(HTTPResponse res, String fieldName)
    {
        List<String> fieldList = new List<String>();
        JSONParser parser = JSON.createParser(res.getBody());
        
        while (parser.nextToken() != null)
        {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == fieldName))
            {
                parser.nextToken();					//go to next token after field name (which will be the actual field value)
                String value = parser.getText();	//get field value string
                fieldList.add(value);
            }
        }
        
        return fieldList;
    }
    
    /* Creates a List of Maps with All Values */
    private static List<Map<String, String>> CreateRecipeList(List<String> pTitles, List<String> pHREFs, List<String> pIngredients, List<String> pThumbnails)
    {
        List<Map<String, String>> recipeList = new List<Map<String, String>>();
        
        for (Integer i = 1; i < pThumbnails.size(); i++)	//start at 1 because 0 is always the recipe puppy filler stuff
        {
            Map<String, String> m = new Map<String, String>();
            m.put('title', pTitles[i]);
            m.put('href', pHREFs[i]);
            m.put('ingredients', pIngredients[i]);
            m.put('thumbnail', pThumbnails[i]);
            
            recipeList.add(m);
            
            /*System.debug('Title: ' + m.get('title') + ' | HREF: ' + m.get('href') + 
                         ' | Ingredients: ' + m.get('ingredients') + ' | Thumbnail: ' + m.get('thumbnail'));*/
        }
        
        return recipeList;
    }
    
    private void OldWay()
    {
        /*
	@AuraEnabled
    public static List<Recipe> RecipeSearch(String dish, String ingredients)
    {
        List<Recipe> resultsList = new List<Recipe>();
        List<String> titleList = new List<String>();
        List<String> hrefList = new List<String>();
        List<String> ingredientsList = new List<String>();
        List<String> thumbnailList = new List<String>();
        
        String dishSearch = dish.deleteWhitespace();
        String ingredientsSearch = ingredients.deleteWhitespace();
        
        /* Get HTTP Response *
            
        Http http = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://www.recipepuppy.com/api/?q=' + dishSearch + '&i=' + ingredientsSearch + '&p=1');
        req.setMethod('GET');
        
        HttpResponse res = http.send(req);
        
        if (res.getStatusCode() == 200)
        {
            /* Parse JSON Response into Lists *
            
            titleList = ParseByField(res, 'title');
            hrefList = ParseByField(res, 'href');
            ingredientsList = ParseByField(res, 'ingredients');
            thumbnailList = ParseByField(res, 'thumbnail');
            
            /* Create Recipe List from Parsed JSON Lists *
            
            resultsList = CreateRecipeList(titleList, hrefList, ingredientsList, thumbnailList);
        }
        else
        {
            System.debug('Status code was not 200. Status = ' + res.getStatusCode());
        }
        
        return resultsList;
    }
    
    /* Creates Lists of Each Field *
    private static List<String> ParseByField(HTTPResponse res, String fieldName)
    {
        List<String> fieldList = new List<String>();
        JSONParser parser = JSON.createParser(res.getBody());
        
        while (parser.nextToken() != null)
        {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && (parser.getText() == fieldName))
            {
                parser.nextToken();					//go to next token after field name (which will be the actual field value)
                String value = parser.getText();	//get field value string
                fieldList.add(value);
            }
        }
        
        return fieldList;
    }
    
    /* Creates a List of Recipe Objects with All Fields *
    private static List<Recipe> CreateRecipeList(List<String> pTitles, List<String> pHREFs, List<String> pIngredients, List<String> pThumbnails)
    {
        List<Recipe> recipeList = new List<Recipe>();
        
        for (Integer i = 1; i < pThumbnails.size(); i++)	//start at 1 because 0 is always the recipe puppy filler stuff
        {
            Recipe r = new Recipe(pTitles[i], pHREFs[i], pIngredients[i], pThumbnails[i]);
            recipeList.add(r);
            
            //System.debug('Title: ' + r.title + ' | HREF: ' + r.href + ' | Ingredients: ' + r.ingredients + ' | Thumbnail: ' + r.thumbnail);
        }
        
        return recipeList;
    }
*/
    }
}