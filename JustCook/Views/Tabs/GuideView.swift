//
//  OneTimeMessageView.swift
//  JustCook
//
//  Created by Eyan Yehya on 8/19/22.
//

import SwiftUI

struct GuideView: View {
    // binding to showingHomePageMessage
    @Binding var showingHomePageMessage: Bool
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("Welcome to the")
                    Text("Home Page!")
                        .foregroundColor(.newPrimaryColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                Button(action: {
                    /* when user clicks on the x button set homeScreenMessageShown in UserDefaults to true so next time app is loaded
                     the message will not be shown. Also set showingHomePageMessage to false and since its a Binding it will inform the
                     HomeScreenView and will remove the message from the screen
                     */
                    UserDefaults.standard.homeScreenMessageShown = true
                    showingHomePageMessage = false
                }) {
                    Image(systemName: "xmark.app")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20, alignment: .trailing)
                }
                .padding(.trailing)
                .foregroundColor(.newPrimaryColor)
            }
            
            Text("Here you will be able to track the recipes you choose to cook as well as view a list of your completed recipes. Click + to begin")
                .padding()
        }
        .overlay(RoundedRectangle(cornerRadius: 2).stroke()
        )
        .padding()
        
    }
}

struct GuideView_Previews: PreviewProvider {
    @State static var showingHomePageMessage = true
    static var previews: some View {
        GuideView(showingHomePageMessage: $showingHomePageMessage)
    }
}
