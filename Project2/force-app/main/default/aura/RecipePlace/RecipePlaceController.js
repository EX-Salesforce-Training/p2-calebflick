({
	searchForRecipes : function(component, event, helper)
    {
		helper.getResponse(component, event, helper);
	},
    
    saveRecipe : function(component, event, helper)
    {
        var recipeID = event.getSource().get("v.name");
        
		helper.doSave(component, event, helper, recipeID);
	}
})