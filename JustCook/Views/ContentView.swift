//
//  ContentView.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/14/22.
//

import SwiftUI

struct ContentView: View {
    let recipes: [Recipe] = RecipeData().recipeData
    
    var body: some View {
        Text("\(recipes.count)")
        
//        List {
//            ForEach(recipes) { recipe in
//                Section(header: Text("\(recipe.Name)")) {
//                    ForEach(recipe.Ingredients, id: \.self) { ingridient in
//                        Text(ingridient)
//                    }
//                }
//            }
//        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
