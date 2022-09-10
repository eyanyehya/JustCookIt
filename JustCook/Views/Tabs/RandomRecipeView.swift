//
//  RandomRecipeView.swift
//  JustCook
//
//  Created by Eyan Yehya on 8/18/22.
//  View that generates random recipes for the user to track based on their current time

import SwiftUI

enum Category {
    case breakfast
    case lunch
    case dinner
}

struct RandomRecipeView: View {
    @EnvironmentObject var recipeData: RecipeData
    @State var isPresenting = false
    
    var body: some View {
        // switch statement based on the users current time
        switch getMealCategory(time: getTime()) {
        
        // if the users current time indicates that its time for breakfast
        case .breakfast:
            ZStack {
                Image("BreakfastBackground")
                    .ignoresSafeArea()
                VStack {
                    // display custom button which once clicked takes the user to the RecipeDetailView with a random recipe
                    ShuffleButton(isPresenting: $isPresenting, randomRecipe: binding(for: recipeData.getRandomRecipe()), mealTime: .breakfast)
                        .environmentObject(recipeData)
                    VStack {
                        Text("Generate my")
                            .fontWeight(.bold)
                        Text("Breakfast!")
                            .fontWeight(.bold)
                            .foregroundColor(.newPrimaryColor)
                    }
                }
            }
            
        // if the users current time indicates that its time for lunch
        case .lunch:
            ZStack {
                Image("LunchBackground")
                    .ignoresSafeArea()
                VStack {
                    ShuffleButton(isPresenting: $isPresenting, randomRecipe: binding(for: recipeData.getRandomRecipe()), mealTime: .lunch)
                        .environmentObject(recipeData)
                    VStack {
                        Text("Generate my")
                            .fontWeight(.bold)
                        Text("Lunch!")
                            .fontWeight(.bold)
                            .foregroundColor(.newPrimaryColor)
                    }
                }
            }
            
        // if the users current time indicates that its time for dinner
        case .dinner:
            ZStack {
                Image("DinnerBackground")
                    .ignoresSafeArea()
                VStack {
                    ShuffleButton(isPresenting: $isPresenting, randomRecipe: binding(for: recipeData.getRandomRecipe()), mealTime: .dinner)
                        .environmentObject(recipeData)
                    VStack {
                        Text("Generate my")
                            .fontWeight(.bold)
                        Text("Dinner!")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

// custom shuffle button
struct ShuffleButton: View {
    @EnvironmentObject var recipeData: RecipeData
    @Binding var isPresenting: Bool
    @Binding var randomRecipe: Recipe
    var mealTime: Category
    
    var body: some View {
        NavigationLink(destination: RecipeDetailView(recipe: $randomRecipe, isPresenting: $isPresenting), label: {
            Image(systemName: "shuffle.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 100)
                .foregroundColor(mealTime == .dinner ? .white : .newPrimaryColor)
        })

    }
}

extension RandomRecipeView {
    // returns binding to random recipe so that user can track the actual recipe rather than a copy
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        for i in recipeData.recipes.indices {
            if recipe.title == recipeData.recipes[i].title {
                return $recipeData.recipes[i]
            }
        }
        fatalError("Recipe not found")
    }
}

//function that returns time in the 24 HR format HH:MM
func getTime() -> String {
    let formatter = DateFormatter()
    formatter.setLocalizedDateFormatFromTemplate("HH:mm a")
    
    //removing am and pm symbols
    formatter.amSymbol = ""
    formatter.pmSymbol = ""
    
    let dateString = formatter.string(from: Date())
    return dateString
}

// function that gets the meal category based on the users current time
func getMealCategory(time: String) -> Category {
    // get hours from time
    let hours: String = String(time.prefix(2))
    
    // if time is for breakfast
    // i.e time is between 6AM and 11 AM
    if Int(hours)! >= 6 && Int(hours)! <= 11 {
        return .breakfast
    }
    // if time is for lunch
    // i.e time is between 12PM and 5PM
    else if Int(hours)! >= 12 && Int(hours)! <= 17 {
        return .lunch
    }
    // if time is for dinner
    // i.e time is between 6PM and 5AM
    else {
        return .dinner
    }
}

struct RandomRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RandomRecipeView()
            .environmentObject(RecipeData())
    }
}
