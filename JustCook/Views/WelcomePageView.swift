//
//  WelcomePage.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/16/22.
//
//  Page that is displayed the first time a user opens the JustCookIt! app

import Foundation
import SwiftUI

struct WelcomePageView: View {
    
    @Binding var isPresenting: Bool
    var body: some View {
        
        VStack {
            Text("Welcome to")
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.black)
                .padding(.top, 20.0)
            Text("JustCookIt!")
                .font(.largeTitle)
                .foregroundColor(.newPrimaryColor)
                .fontWeight(.black)

            List {
                HStack {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 23)
                        .foregroundColor(.newPrimaryColor)
                        .padding(.trailing)
                    VStack {
                        Text("Generate")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Type in your ingredients to generate possible recipes from our large recipes database")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                    }
                }
                .listRowBackground(Color.clear)
                HStack {
                    Image(systemName: "list.number")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .foregroundColor(.newPrimaryColor)
                        .padding(.trailing)
                    VStack {
                        Text("Cook")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Step-by-step, easy to follow directions and precise measurements, making your cooking journey as easy as 🥧")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                    }
                }
                .listRowBackground(Color.clear)
                HStack {
                    Image(systemName: "shuffle")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .foregroundColor(.newPrimaryColor)
                        .padding(.trailing)
                    VStack {
                        Text("Randomize")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("Not quite sure what meal to make? Get random recipes based on\nyour time of day. So that you can search less and eat more!")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                    }
                }
                .listRowBackground(Color.clear)
                HStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30)
                        .foregroundColor(.newPrimaryColor)
                        .padding(.trailing)
                    VStack {
                        Text("Favorite")
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Text("Save your favorite recipes in one place for quick and easy access")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.gray)
                        
                    }
                }
                .listRowBackground(Color.clear)
            }
            
//            Text("Tired of spending your money on restaurant trips 💵? Ever think of making a dish but always missing a few ingredients 🍽? No need to worry, JustCook! \n\nSimply type in what ingredients you have and our app will give you recipes you can make! What are you waiting for? JustCook!")
//                .lineSpacing(3)
//                .multilineTextAlignment(.leading)
//                .padding()
            
            
            Button(action: {
                isPresenting = false
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
            }, label: {
                Label("Start", systemImage: "fork.knife").frame(minWidth: 0, maxWidth: .infinity, maxHeight: 40)
            })
            .buttonBorderShape(.roundedRectangle)
            .buttonStyle(.borderedProminent)
            .frame(maxWidth: .infinity)
            .tint(.newPrimaryColor)
            .padding()
            


            Spacer()
            Spacer()
        }
    }
}

struct WelcomePageView_Previews: PreviewProvider {
    @State static var isPresenting: Bool = true
    static var previews: some View {
        WelcomePageView(isPresenting: $isPresenting)
            .preferredColorScheme(.dark)
    }
}
