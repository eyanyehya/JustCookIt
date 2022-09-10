//
//  RecipeData.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/15/22.
//

import Foundation
import SwiftUI
import NaturalLanguage

class RecipeData: ObservableObject {
    @Published var recipes = [Recipe]()
    @Published var usersRecipes = [Recipe]()

    var ingredientToRecipeMap = [String: [Recipe]]()
    var allIngredients = Set<String>()

    // init function that calls the load function
    init() {
        loadAllRecipes()
        setUpMap()
    }
    
    private var documentDirectory: URL {
      try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
    
    // CODE TO SAVE AND LOAD USERS TRACKED RECIPES
    private var usersRecipesFile: URL {
        documentDirectory
            .appendingPathComponent("usersRecipes")
            .appendingPathExtension(for: .json)
    }
    
    func saveUsersRecipes() throws {
        let data = try JSONEncoder().encode(usersRecipes)
        try data.write(to: usersRecipesFile)
    }
    
    func loadUsersRecipes() throws {
      guard FileManager.default.isReadableFile(atPath: usersRecipesFile.path) else { return }
      let data = try Data(contentsOf: usersRecipesFile)
      usersRecipes = try JSONDecoder().decode([Recipe].self, from: data)
    }
    
    // FUNCTION TO CONVERT DATA FROM JSON TO RECIPE
    func loadAllRecipes() {
        // get a url that corresponds to the recipes.json file
        if let fileLocation: URL = Bundle.main.url(forResource: "recipe_data", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                // from the array of json data to an array of Recipes
                // now dataFromJson is an array of Recipes
                let dataFromJson = try jsonDecoder.decode([Recipe].self, from: data)
                self.recipes = dataFromJson
            } catch {
                print(error)
            }
        }
    }
    
    func setUpMap() {
        for recipe in recipes {
            for ingredient in recipe.NER {
                // if the ingredient(lemmatized) in the recipe is NOT a key so there is no key-value pair
                if ingredientToRecipeMap[ingredient] == nil {
                    // create a new key value pair
                    ingredientToRecipeMap[ingredient] = [recipe]
                }
                // if theingredient(lemmatized) in the recipe IS a key so there is a key-value pair
                else {
                    // append to the recipes list the current recipe
                    ingredientToRecipeMap[ingredient]?.append(recipe)
                }
            }
        }
    }
    
    func getValidRecipe(ingredients: [String]) -> [Recipe] {
        // get all recipes that contain the first input ingredient
        var output = Set<Recipe>()
        
        // list of users input ingredients lowercased and without whitespace
        var ingredientsLowerCased = ingredients.map({ $0.lowercased() }).map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
        ingredientsLowerCased.append("salt")
        ingredientsLowerCased.append("water")
        ingredientsLowerCased.append("sugar")
        ingredientsLowerCased.append("oil")
        ingredientsLowerCased.append("pepper")
        
        for ingredient in ingredientsLowerCased {
            if let recipes = ingredientToRecipeMap[ingredient] {
                for recipe in recipes {
                    // look at one of the recipes in the list of recipes that have the first input ingredient
                    // look at the raw ingredients of that recipe
                    // if all the ingredients in that recipe are in the input add recipe to output list
                    // this means that all the ingredients needed for the recipe are in the input but not necessarily that all inputs are in the recipe
                    // so eg. input could be [a, b, c] and recipe could be [a, b]
                    if recipe.NER.allSatisfy({ ingredientsLowerCased.contains($0) }) {
                        output.insert(recipe)
                    }
                }
            }
        }

        return Array(output)
    }
    
    
    func getRandomRecipe() -> Recipe {
        let index = Int.random(in: 0..<recipes.count)
        return recipes[index]
    }
    
    // FUNCTION THAT SORTS DATA
    func sort() {
        self.recipes = self.recipes.sorted(by: { $0.title < $1.title })
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
    func getFavorites() -> [Recipe] {
        usersRecipes.filter({ $0.isFavorite ?? false })
    }
    
    func getTrackedRecipes() -> [Recipe] {
        usersRecipes.filter({ $0.isTracked ?? false })
    }
    
    func getCompleteRecipes() -> [Recipe] {
        usersRecipes.filter({ $0.isComplete ?? false })
    }
}
