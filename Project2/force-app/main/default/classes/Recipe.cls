public class Recipe
{
    @AuraEnabled
    public String title {get; set;}
    @AuraEnabled
    public String href {get; set;}
    @AuraEnabled
    public String ingredients {get; set;}
    @AuraEnabled
    public String thumbnail {get; set;}
    
    public Recipe(String title, String href, String ingredients, String thumbnail)
    {
        this.title = title;
        this.href = href;
        this.ingredients = ingredients;
        this.thumbnail = thumbnail;
    }
}