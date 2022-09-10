//
//  HomeScreenView.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/16/22.
//
// Home Screen where users will be able to see the recipes they've tracked and completed

import Foundation
import SwiftUI
import AudioToolbox

struct HomeScreenView: View {
    
    // variable that is true when the user clicks to input their ingredients
    @State var isPresenting: Bool = false
    
    // view model
    @EnvironmentObject var recipeData: RecipeData
    
    // boolean variable initially set to true and used to display home page message to user
    @State var showingHomePageMessage = !UserDefaults.standard.homeScreenMessageShown
    
    var body: some View {
            VStack {
                // if user is has not closed the home page guide then display it 
                if showingHomePageMessage {
                    GuideView(showingHomePageMessage: $showingHomePageMessage)
                }
                
                // if the user has not tracked or completed any recipes display a helper message
                if recipeData.getTrackedRecipes().isEmpty && recipeData.getCompleteRecipes().isEmpty {
                    VStack {
                        Text("What are you doing there staring with that empty plate..")
                        Text("🍽")
                            .font(.largeTitle)
                            .padding()
                        Text("Click on the + button and JustCookIt!")
                    }
                    .padding()
                }
                
                List {
                    // if the user has tracked at least one recipe
                    if !recipeData.getTrackedRecipes().isEmpty {
                        Section(header: Text("Tracked Recipes 📌")) {
                            // for each tracked recipe display it as a NavigationLink
                            ForEach(recipeData.getTrackedRecipes()) { recipe in
                                NavigationLink(destination:
                                                MakeRecipeView(recipe: binding(for: recipe), IngredientChecks: [Bool](repeating: false, count: recipe.ingredients.count), DirectionChecks: [Bool](repeating: false, count: recipe.directions.count))
                                    .environmentObject(recipeData)
                                ) {
                                    // NavigationLink styling
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(recipe.title)
                                            Text("\(recipe.ingredients.count) Ingredients").font(.subheadline).foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Text("\(recipe.directions.count) steps")
                                    }
                                }
                            }
                        }
                    }
                    
                    // if the user has completed at least one recipe
                    if !recipeData.getCompleteRecipes().isEmpty {
                        Section(header: Text("Completed Recipes ✅")) {
                            ForEach(recipeData.getCompleteRecipes()) { recipe in
                                NavigationLink(destination:
                                                MakeRecipeView(recipe: binding(for: recipe), IngredientChecks: [Bool](repeating: false, count: recipe.ingredients.count), DirectionChecks: [Bool](repeating: false, count: recipe.directions.count))
                                    .environmentObject(recipeData)
                                ) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(recipe.title)
                                            Text("\(recipe.ingredients.count) Ingredients").font(.subheadline).foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Text("\(recipe.directions.count) steps")
                                    }
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
            }
        
            // the + button
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // once clicked set isPresenting to true which will trigger the sheet to be displayed
                        isPresenting = true
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    }, label: {
                        VStack {
                            Image(systemName: "plus")
                        }
                    })
                }
            }
            .sheet(isPresented: $isPresenting, content: {
                NavigationView {
                    InputIngredientsView(isPresenting: $isPresenting)
                        .environmentObject(recipeData)
                }
            })
            
        // setting color of Navigation bar
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            appearance.backgroundColor = UIColor(Color.newPrimaryColor.opacity(0.2))
            
            // Inline appearance (standard height appearance)
            UINavigationBar.appearance().standardAppearance = appearance
            // Large Title appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}

extension HomeScreenView {
    /* function that returns a binding to a recipe in the users recipes.
     Allows for the access of the same recipe reference so that changes like tracking
     and untracking recipes are made on the main recipe not a copy
     */
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        for i in recipeData.usersRecipes.indices {
            if recipe.title == recipeData.usersRecipes[i].title {
                return $recipeData.usersRecipes[i]
            }
        }
        fatalError("Recipe not found")
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
            .environmentObject(RecipeData())
    }
}
