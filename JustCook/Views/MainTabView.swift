//
//  MainTabView.swift
//  JustCook
//
//  Created by Eyan Yehya on 8/2/22.
//  First view that gets displayed when user opens the app. If its the first time the user is opening the app the WelcomePageView() will be shown

import SwiftUI

// adding variable in UserDefaults that allows us to display the welcome screen view and home screen message only once to the user
extension UserDefaults {
    var welcomeScreenShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "welcomeScreenShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "welcomeScreenShown")
        }
    }
    
    var homeScreenMessageShown: Bool {
        get {
            return (UserDefaults.standard.value(forKey: "homeScreenMessageShown") as? Bool) ?? false
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "homeScreenMessageShown")
        }
    }
}

struct MainTabView: View {
    
    // view model that allows us to interact between views and the models
    @StateObject var recipeData: RecipeData = RecipeData()
    
    // showingWelcomePage is initially set to true because welcomeScreenShown is false (since there is no key value pair set)
    @State var showingWelcomePage: Bool = !UserDefaults.standard.welcomeScreenShown
    
    var body: some View {
        // View that will allow the user to choose between a Home Page, a Randomizer Page and a Favorites Page
        TabView {
            // 1. Home screen view
            NavigationView {
                HomeScreenView()
                    .navigationTitle("Home 🥝")
            }
            .tabItem { Label("Home", systemImage: "house") }
            
            // 2. Randomizer view
            NavigationView {
                RandomRecipeView()
                    .navigationTitle("Randomizer 🥨")
            }
            .tabItem { Label("Randomizer", systemImage: "shuffle") }
            
            // 3. Favorites view
            NavigationView {
                FavoritesView()
                    .navigationTitle("Favorites 🍓")
            }
            .tabItem { Label("Favorites", systemImage: "heart.fill") }
        }
        .environmentObject(recipeData)
        
        
        // will be displayed when the user first launches the app since showingWelcomePage is true
        .sheet(isPresented: $showingWelcomePage, content: {
            // if statement will be true initially so WelcomePageView() is displayed
            if UserDefaults.standard.welcomeScreenShown == false {
                WelcomePageView(isPresenting: $showingWelcomePage)
                
                // when WelcomePageView() is shown welcomeScreenShown its set to true so showingWelcomePage is false and the WelcomePageView() will not be shown when the user relaunches the app
                    .onAppear(perform: {
                        UserDefaults.standard.welcomeScreenShown = true
                    })
            }
        })
        
        // when the main tab view is shown load the users recipes
        .onAppear {
            // try! means if an error occurs crash the entire app
            try! recipeData.loadUsersRecipes()
        }
        
        // when the users recipes changes save the recipes
        .onChange(of: recipeData.usersRecipes) { _ in
            try! recipeData.saveUsersRecipes()
        }
    }
}

// adding custom colors
extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let newPrimaryColor = Color("newPrimaryColor")
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
