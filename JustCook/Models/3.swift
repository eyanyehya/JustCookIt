//
//  Recipe.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/14/22.
//

import Foundation
import SwiftUI

struct Recipe: Codable, Identifiable, Hashable {
    // required because Recipe conforms to Identifiable
    var id = UUID()
    
    
    // properties
    var Name: String
    var url: String
    var Description: String?
    var Author: String?
    var Ingredients: [String]
    var Method: [String]
    
    // all properties that are in the json file everything else will be ignored i.e decoder will word even though id is not a property in the json file
    private enum CodingKeys: String, CodingKey { case Name, url, Description, Author, Ingredients, Method  }
    
    func getWord(str: String) -> Bool {
        if str.lowercased().contains("onion") {
            return true
        }
        else {
            return false
        }
    }
    

}
