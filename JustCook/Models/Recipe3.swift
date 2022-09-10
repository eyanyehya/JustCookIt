//
//  Recipe.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/14/22.
//

import Foundation
import SwiftUI

struct Recipe3: Identifiable {
    // in order to conform to Identifiable protocol
    var id = UUID()
    var mainInfo: MainInformation
    var ingridients: [Ingridient]
    var directions: [String]
}

struct MainInformation {
    var name: String
    var url: URL
    var author: String
    var description: String
}

struct Ingridient {
    var name: String
    var quantity: Int
    var unit: Unit
    // for knob, finely cut, etc.
    var extra: String?
    
    enum Unit: String {
        case oz = "Ounces"
        case g = "Grams"
        case cups = "Cups"
        case tbs = "Tablespoons"
        case tsp = "Teaspoons"
        case none = "No Units"
    }
}
