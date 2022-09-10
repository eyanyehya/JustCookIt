//
//  MakeRecipeView.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/31/22.
//  View that has checklists for both ingredients and directions allowing the user to track their progress

import SwiftUI

struct MakeRecipeView: View {
    @Binding var recipe: Recipe
    @State var IngredientChecks: [Bool]
    @State var DirectionChecks: [Bool]
    @EnvironmentObject var recipeData: RecipeData
    @State private var selection = Selection.ingredients
    
    enum Selection {
        case ingredients
        case directions
    }
    
    var body: some View {
        VStack {
            Picker("Select ingredient format", selection: $selection) {
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            List {
                switch selection {
                case .ingredients:
                    Section(header: Text("Ingredients")) {
                        
                        // if IngredientChecks array has all true values then all checks are ticked
                        if IngredientChecks.allSatisfy({ $0 }) {
                            HStack {
                                Spacer()
                                Label("All Ingredients Gathered!", systemImage: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                                Spacer()
                            }
                        }
                        // if not all checks are ticked
                        else {
                            ForEach(recipe.ingredients.indices, id: \.self) { index in
                                HStack {
                                    Text(recipe.ingredients[index])
                                    Spacer()
                                    Button(action: {
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                        IngredientChecks[index].toggle()
                                    }, label: {
                                        // if check has not been clicked then display a square otherwise display a checkmark
                                        IngredientChecks[index] == false ? Image(systemName: "square") : Image(systemName: "checkmark.square.fill")
                                        
                                    })
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                    }
                case .directions:
                    // if DirectionChecks array has all true values then all checks are ticked
                    if DirectionChecks.allSatisfy({ $0 }) {
                        HStack {
                            Spacer()
                            Label("Recipe complete!", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.green)
                            Spacer()
                        }
                        Button(action: {
                            DirectionChecks = DirectionChecks.map({ !$0 })
                        }, label: { Label("Redo", systemImage: "arrow.uturn.forward.circle.fill") })
                        .frame(maxWidth: .infinity)
                    }
                    // if not all checks are ticked
                    else {
                        Section(header: Text("Directions")) {
                            ForEach(recipe.directions.indices, id: \.self) { index in
                                HStack {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                    Text("\(recipe.directions[index])")
                                    Spacer()
                                    Button(action: {
                                        DirectionChecks[index].toggle()
                                        // if user has checked all the directions add the current recipe to the array of completed recipes
                                        if DirectionChecks.allSatisfy({ $0 }) {
                                            recipeData.usersRecipes.append(Recipe(isFavorite: false, isTracked: false, isComplete: true, title: recipe.title, ingredients: recipe.ingredients, directions: recipe.directions, link: recipe.link, source: recipe.source, NER: recipe.NER))
                                        }
                                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    }, label: {
                                        // if check has not been clicked then display a square otherwise display a checkmark
                                        DirectionChecks[index] == false ? Image(systemName: "square") : Image(systemName: "checkmark.square.fill")
                                    })
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                    }
                }
            }
            if recipe.isTracked ?? false {
                Button(action: {recipe.isTracked?.toggle()}, label: {Text("Untrack Recipe").fontWeight(.bold).frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)})
                    .padding()
                    .tint(.newPrimaryColor)
                    .buttonStyle(BorderedProminentButtonStyle())
            }
            else {
                Button(action: {recipe.isTracked?.toggle()}, label: {Text("Track Recipe").fontWeight(.bold).frame(minWidth: 0, maxWidth: .infinity, maxHeight: 50)})
                    .padding()
                    .tint(.newPrimaryColor)
                    .buttonStyle(BorderedProminentButtonStyle())
            }
            
        }
        .navigationBarTitle(recipe.title)
        // favoriting a recipe
        .toolbar {
            ToolbarItem {
                Button(action: {
                    if let check = recipe.isFavorite {
                        if check {
                            recipe.isFavorite = false
                        }
                        else {
                            recipe.isFavorite = true
                        }
                    }
                }) {
                    Image(systemName: recipe.isFavorite ?? false ? "heart.fill" : "heart")
                }
            }
        }
    }
}
