//
//  RecipeDetailView.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/25/22.
//  Detail view of a single recipe

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @State private var selection = Selection.ingredients
    @EnvironmentObject var recipeData: RecipeData
    @Binding var isPresenting: Bool
    
    enum Selection {
        case ingredients
        case directions
    }
    
    var body: some View {
        VStack {
            // picker between ingredients and directions based on value of selection variable
            Picker("Select ingredient format", selection: $selection) {
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            List {
                switch selection {
                // if selection is .ingredients then display info about ingredients
                case .ingredients:
                    Section(header: Text("Ingredients")) {
                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                            Text(ingredient)
                        }
                    }
                    Section(header: Text("Raw Ingredients")) {
                        ForEach(recipe.NER, id: \.self) { ingredient in
                            Text(ingredient)
                        }
                    }
                // if selection is .directions then display info about directions
                case .directions:
                    Section(header: Text("Directions")) {
                        ForEach(recipe.directions.indices, id: \.self) { index in
                            HStack {
                                Text("\(index + 1).")
                                    .fontWeight(.bold)
                                Text("\(recipe.directions[index])")
                            }
                        }
                    }
                }
            }
            HStack {
                // button that once clicked adds a recipe to usersRecipes with isTracked = true
                // sets isPresenting is false so lowers sheet
                Button(action: {
                    recipeData.usersRecipes.append(Recipe(isFavorite: false, isTracked: true, isComplete: false, title: recipe.title, ingredients: recipe.ingredients, directions: recipe.directions, link: recipe.link, source: recipe.source, NER: recipe.NER))
                    isPresenting = false
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()

                }) {
                    Text("Track Recipe")
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                .padding()
                .tint(.newPrimaryColor)
                .buttonStyle(BorderedProminentButtonStyle())
                
                // if this view is being called from RandomRecipeView then display a Next Recipe button that sets recipe to a random recipe
                if isPresenting == false {
                    Button(action: {
                        recipe = recipeData.getRandomRecipe()
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    }) {
                        Text("Next Recipe")
                            .fontWeight(.bold)
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .padding()
                    .tint(.newPrimaryColor)
                    .buttonStyle(BorderedProminentButtonStyle())
                }
            }
        }
        .navigationBarTitle(recipe.title)
        .controlSize(.large)
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe(isFavorite: false, isTracked: false, isComplete: false, title: "test recipe", ingredients: ["t1", "t2"], directions: ["do t1"], link: "www.test.com", source: "Gathered", NER: ["t1"])
    @State static var isPresenting = true
    static var previews: some View {
        RecipeDetailView(recipe: $recipe, isPresenting: $isPresenting)
    }
}
