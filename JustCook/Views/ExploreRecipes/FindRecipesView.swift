//
//  FindRecipesView.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/19/22.
//  View that displays a list of possible recipes a user can make with their input ingredients or message if no recipes exist

import Foundation
import SwiftUI

struct FindRecipesView: View {
    
    // users input ingredients
    @Binding var ingredients: [String]
    @EnvironmentObject var recipeData: RecipeData
    @Binding var isPresenting: Bool
    
    var body: some View {
        VStack {
            if let validRecipes = recipeData.getValidRecipe(ingredients: ingredients) {
                if validRecipes.isEmpty {
                    Text("Sorry we couldn't find any possible recipes for you to make with your ingredients at the moment.\nCommon reasons:\n- Spelling mistakes\n- Missing ingredients\n- We simply don't have any recipes with your ingredients in our database\nThe more ingredients you type in the higher the chances of you finding recipes, so we recommend you type in more ingredients. So get to searching that fridge!")
                        .italic()
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 2).stroke())
                        .padding()
                    Spacer()

                }
                else {
                    // if validRecipes list is not empty then display its elements as a NavigationLink to RecipeDetailView
                    List {
                        Section(header: Text("Possible Recipes")) {
                                ForEach(validRecipes, id: \.self) { recipe in
                                    NavigationLink(destination: RecipeDetailView(recipe: binding(for: recipe), isPresenting: $isPresenting)
                                        .environmentObject(recipeData), label: {
                                        Text("\(recipe.title)")
                                    })
                                }


                        }
                    }
                }
            }
        }
        .navigationTitle(Text("Recipes"))
    }
}

extension FindRecipesView {
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        for i in recipeData.recipes.indices {
            if recipe.title == recipeData.recipes[i].title {
                return $recipeData.recipes[i]
            }
        }
        fatalError("Recipe not found")
    }
}

struct FindRecipesView_Previews: PreviewProvider {
    @State static var ingredients: [String] = ["Apple", "Orange"]
    @State static var isPresenting = true
    static var previews: some View {
        FindRecipesView(ingredients: $ingredients, isPresenting: $isPresenting)
            .environmentObject(RecipeData())
    }
}
