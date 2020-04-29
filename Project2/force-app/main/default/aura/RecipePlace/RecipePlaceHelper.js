({
	getResponse : function(component, event, helper)
    {
		var action = component.get("c.RecipeSearch");
        action.setParams({"dish": component.get("v.dish"), "ingredients": component.get("v.ingredients")});
        
        action.setCallback(this, function(response)
        {
            var state = response.getState();
            
            if (state == "SUCCESS")
            {
                var recipeList = [];
                
                for (var recipe in response.getReturnValue())
                {
                	//recipeList.push(recipe);
                    recipeList.push({value:response.getReturnValue()[recipe], key:recipe});
                    //console.log(recipe.title);
                    //console.log(response.getReturnValue()[recipe].title);
                }
                
                component.set("v.recipeList", recipeList);
                //console.log(component.get("v.recipeList")[0].value.title);
            }
            else if (state == "INCOMPLETE")
            {
                console.log("State is INCOMPLETE");
            }
            else if (state == "ERROR")
            {
                console.log("State is ERROR");
            }
        });
        
        $A.enqueueAction(action);
	},
    
    doSave : function(component, event, helper, recipeID)
    {
        console.log(component.get("v.recipeList")[recipeID].value.title);
        
		var action = component.get("c.SaveRecipe");
        action.setParams({"pName": component.get("v.recipeList")[recipeID].value.title, "pURL": component.get("v.recipeList")[recipeID].value.href});
        
        action.setCallback(this, function(response)
        {
            var state = response.getState();
            
            if (state == "SUCCESS")
            {
                //do things here
            }
            else if (state == "INCOMPLETE")
            {
                console.log("State is INCOMPLETE");
            }
            else if (state == "ERROR")
            {
                console.log("State is ERROR");
            }
        });
        
        $A.enqueueAction(action);
	}
})