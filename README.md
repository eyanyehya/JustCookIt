# JustCookIt
An IOS application created using SwiftUI and used to recommend recipes a user can make based on the ingredients they have.

# Project Screenshots

<table>
  <tr>
    <td>Home Page</td>
    <td>Input Ingredients Page</td>
    <td>Outputted recipes page</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/64728439/200691633-70511ec6-b230-417f-8a77-df5664de957f.png"></td>
    <td><img src="https://user-images.githubusercontent.com/64728439/200692221-0eacc2ed-04c5-4575-9b73-601c2cd29824.png"></td>
    <td><img src="https://user-images.githubusercontent.com/64728439/200692546-ea49bf91-0ed5-41f4-b354-55bdc6f44771.png"></td>
  </tr>
  <tr>
    <td>Chosen Recipe Detail Page</td>
    <td>Randomizer Page</td>
    <td>Random Recipe Detail Page</td>
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/64728439/200693030-c936980a-de85-4376-8da0-501a3aa9efa3.png"></td>
    <td><img src="https://user-images.githubusercontent.com/64728439/200693184-f4450aab-974b-45a9-ae07-20583310f190.png"></td>
    <td><img src="https://user-images.githubusercontent.com/64728439/200693304-5b13788a-540d-4be0-b2a1-6f50bbcefbd2.png"></td>
  </tr>
  <tr>
    <td>Favorites Page</td>
    <td>Initial Home Page before adding Recipes</td>


  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/64728439/200693370-22c89efc-c51d-49fb-9786-2a2519ab2fd6.png"></td>
    <td><img src="https://user-images.githubusercontent.com/64728439/200899119-690535da-45b0-48d3-b429-02ab1c87ca7c.png"></td>


  </tr>
 </table>
 
 # Installation and Setup Instructions
 Download the project and run using Xcode
 
# Reflection
This was a project I worked on over the summer of 2022 and is inspired by my lifestyle as a university student. Being a university student I noticed that I was eating out more than my bank account would recommend me to, while the ingredients I had at home were being thrown out one after the other. Wanting to waste less food and save some money inspired me to create JustCookIt! The concept is fairly simple. You input ingredients you have lying around at home and the app will return a list of recipes that you can make only using those ingredients. Some project goals included getting more familiar with the MVVM (Model, View, View Model) design pattern, creating a simple and intuitive UI, learning how to make users information persistent after app restarts, and converting json data into my own data structure to then be used in my views. 

A big challenge I ran into was finding a good dataset. I wanted it to be in json format so that I can take advantage of the built in JSONDecoder and Encoder functions in Swift as well as have the ingredients list be as simple as possible so that I could do simple and fast queries based on input ingredients. I ended up using a free Kaggle dataset. Another challenge was performing fast queries. With over 6000 recipes each with its own list of ingredients I initially thought of simply going through every recipe and comparing the list of ingredients to the input list and if they are the same add that recipe to the outputted list. But after further thought I decided to create a map (only once) that maps ingredients to list of recipes that include those ingredients. For eg. a recipe R1 with [water, bread] would translate to the following map { water : [R1], bread : [R1] }. Having this would make evaluating a query much simpler as I would only look at the recipes that include the input ingredients rather than all recipes. The code for this logic is seen below where the function takes the list of users ingredients as an input and outputs the list of valid recipes. Note that I added to the list of users ingredients some ingredients like water and salt that almost everyone has such that the results are accurate (since some recipes have salt as an ingredient).

~~~swift
   func getValidRecipe(ingredients: [String]) -> [Recipe] {
        // get all recipes that contain the first input ingredient
        var output = Set<Recipe>()
        
        // list of users input ingredients lowercased and without whitespace
        var ingredientsLowerCased = ingredients.map({ $0.lowercased() }).map({ $0.trimmingCharacters(in: .whitespacesAndNewlines) })
        
        // add some common ingredients 
        ingredientsLowerCased.append("salt")
        ingredientsLowerCased.append("water")
        ingredientsLowerCased.append("sugar")
        ingredientsLowerCased.append("oil")
        ingredientsLowerCased.append("pepper")
        
        // for all the ingredients that user inputted + the ingredients I added above 
        for ingredient in ingredientsLowerCased {
            // if there is at least one recipe that requires the ingredient 
            if let recipes = ingredientToRecipeMap[ingredient] {
                // go through all the recipes that require the ingredient 
                for recipe in recipes {
                    // look at one of the recipes in the list of recipes that have the input ingredient
                    // look at the raw ingredients of that recipe
                    // if all the ingredients in that recipe are in the input add recipe to output list
                    // this means that all the ingredients needed for the recipe are in the input but not necessarily that all inputs are in the recipe
                    // so eg. input could be [a, b, c] and recipe could be [a, b]
                    if recipe.NER.allSatisfy({ ingredientsLowerCased.contains($0) }) {
                        // add the recipe to the output list 
                        output.insert(recipe)
                    }
                }
            }
        }
        
        // return the list of valid recipes 
        return Array(output)
    }
~~~

In terms of tools I used XCode and the Swift programming language, following the very strong MVVM design pattern that I learnt after finishing the Codecademy IOS development course. As seen below it allows me to seperate important aspects of the app into distinct sections that all interact with one another to achieve the goal. 

<img width="267" alt="image" src="https://user-images.githubusercontent.com/64728439/200907396-2868f5c5-c8cd-46a2-8a26-fcab7bff843d.png">





