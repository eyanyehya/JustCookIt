//
//  InputIngredientsView.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/17/22.
//  View that allows the user to input whatever ingredients they have at their disposal

import Foundation
import SwiftUI

struct InputIngredientsView: View {
    // array of ingredients (strings) that the user inputs
    @State var ingredientsAdded: [String] = [""]
    
    // individual new ingredient that the user inputs in a TextField
    @State var newIngredient: String = ""
    
    // recipeData allows us to access the view model in this view
    @EnvironmentObject var recipeData: RecipeData
    
    @Binding var isPresenting: Bool
    
    var body: some View {
            VStack {
                // if the user has deleted all the TextFields (using edit) display an informative Text()
                if ingredientsAdded.isEmpty {
                    Text("Click on the '+' button to add new ingredient")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.red)
                        .italic()
                        .padding()
                }
                
                // form where the user can input their ingredients
                Form {
                    Section(header: Text("My Ingredients"), footer: Text("Enter ingredients you have to get possible recipes")) {
                        // for every string in ingredientsAdded array show a CustomTextField()
                        ForEach(0..<(ingredientsAdded.count), id: \.self) { index in
                            HStack {
                                CustomTextField(ingredient: $ingredientsAdded[index], index: index)
                            }
                        }
                        .onDelete(perform: removeIngredient)

                        Button(action: {
                            ingredientsAdded.append("")
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .frame(maxWidth: .infinity)
                    }
                }
                .navigationBarTitle("Ingredients")
                .toolbar {
                    EditButton()
                }
                .onSubmit({
                    ingredientsAdded.append("")
                })

                // if recipes can be potentially generated display a button
                if canGenerateRecipesCheck() {
                    VStack {
                        NavigationLink(destination: {
                            FindRecipesView(ingredients: $ingredientsAdded, isPresenting: $isPresenting)
                            // environment object so FindRecipesView can access recipeData
                            .environmentObject(recipeData)
                        }, label: {
                            Label("Generate Recipes!", systemImage: "fork.knife")
                        })
                        .buttonBorderShape(.roundedRectangle)
                        .buttonStyle(.bordered)
                        .tint(.blue)
                    }
                }
            }
    }
    
    // function that removes ingredient at an offset
    func removeIngredient(at offset: IndexSet) {
        ingredientsAdded.remove(atOffsets: offset)
    }
    
    // function that returns true if the user has inputted ingredients in every TextField() and false otherwise
    func canGenerateRecipesCheck() -> Bool {
        if ingredientsAdded.count == 0 {
            return false
        }
        
        for ing in ingredientsAdded {
            if ing == "" {
                return false
            }
        }
        return true
    }
}

struct CustomTextField : View {
    @Binding var ingredient : String
    var index : Int
    
    var body : some View {
        HStack {
            TextField("Enter Ingredient", text: $ingredient)
        }
    }
}


struct InputIngredientsView_Previews: PreviewProvider {
    @State static var isPresenting = true
    static var previews: some View {
        InputIngredientsView(isPresenting: $isPresenting)
            .environmentObject(RecipeData())
    }
}
