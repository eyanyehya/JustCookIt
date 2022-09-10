//
//  FavoritesView.swift
//  JustCook
//
//  Created by Eyan Yehya on 8/2/22.
//  View that displays a list of the users favorite recipes

import SwiftUI

struct FavoritesView: View {
    // view model
    @EnvironmentObject var recipeData: RecipeData
    
    var body: some View {
        VStack {
            // if the user has not favorited any recipes
            if recipeData.getFavorites().isEmpty {
                Text("You do not have any recipes favorited yet. In order to favorite a recipe click the ❤️ button")
                    .padding()
                    .font(.callout)
                Image("HowToFavoriteRecipeBefore")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Image("HowToFavoriteRecipeAfter")
                    .resizable()
                    .scaledToFit()
                    .padding()
            }
            // if the user has favorited at least one recipe
            else {
                // display the favorited recipes as a list of NavigationLinks to the recipes
                List {
                    Section(header: Text("Favorite Recipes")) {
                        ForEach(recipeData.getFavorites()) { recipe in
                            NavigationLink(destination: { MakeRecipeView(recipe: binding(for: recipe), IngredientChecks: [Bool](repeating: false, count: recipe.ingredients.count), DirectionChecks: [Bool](repeating: false, count: recipe.directions.count)) }, label: { Text("\(recipe.title)") })
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
    }
}

extension FavoritesView {
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        for i in recipeData.usersRecipes.indices {
            if recipe.title == recipeData.usersRecipes[i].title {
                return $recipeData.usersRecipes[i]
            }
        }
        fatalError("Recipe not found")
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RecipeData())
    }
}
