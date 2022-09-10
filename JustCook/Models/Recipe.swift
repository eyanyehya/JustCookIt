//
//  Recipe.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/14/22.
//  Data structure to represent a single Recipe

import Foundation
import SwiftUI

struct Recipe: Codable, Identifiable, Hashable {
    // required because Recipe conforms to Identifiable 
    var id = UUID()
    
    // optional booleans used to display specific recipes in specific lists (eg. favorites list)
    var isFavorite: Bool?
    var isTracked: Bool?
    var isComplete: Bool?
    
    // properties
    var title: String
    // detailed ingredients (eg. 1/2 tbs of sugar)
    var ingredients: [String]
    var directions: [String]
    var link: String
    var source: String
    // raw ingredients (eg. sugar)
    var NER: [String]
    
    // all properties that are in the json file everything else will be ignored i.e decoder will work even though id is not a property in the json file
    private enum CodingKeys: String, CodingKey { case title, ingredients, directions, link, source, NER, isFavorite, isTracked, isComplete  }
}
