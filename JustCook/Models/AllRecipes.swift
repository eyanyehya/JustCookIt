//
//  AllRecipes.swift
//  JustCook
//
//  Created by Eyan Yehya on 7/14/22.
//

import Foundation
import SwiftUI

extension Recipe3 {
    static let allRecipes: [Recipe3] = [
        Recipe3(mainInfo:
                MainInformation(name: "Christmas pie", url: URL(string: "https://www.bbcgoodfood.com/recipes/2793/christmas-pie")!, author: "Mary Cadogan", description: "Combine a few key Christmas flavours here to make a pie that both children and adults will adore"),
               ingridients: [Ingridient(name: "olive oil", quantity: 2, unit: .tbs),
                             Ingridient(name: "butter", quantity: 1, unit: .none, extra: "knob"),
                             Ingridient(name: "onion", quantity: 1, unit: .none, extra: "finely chopped"),
                             Ingridient(name: "sausage", quantity: 500, unit: .g),
                             Ingridient(name: "lemon", quantity: 1, unit: .none, extra: "grated zest"),
                             Ingridient(name: "breadcrumbs", quantity: 100, unit: .g),
                             Ingridient(name: "apricot", quantity: 85, unit: .g),
                             Ingridient(name: "chestnut", quantity: 50, unit: .g),
                             Ingridient(name: "thyme", quantity: 2, unit: .tbs),
                             Ingridient(name: "cranberry", quantity: 100, unit: .g),
                             Ingridient(name: "chicken breast", quantity: 500, unit: .g),
                             Ingridient(name: "egg", quantity: 1, unit: .none),
                             Ingridient(name: "pastry", quantity: 500, unit: .g)],
               directions: [
                "Heat oven to 190C/fan 170C/gas 5. Heat 1 tbsp oil and the butter in a frying pan, then add the onion and fry for 5 mins until softened. Cool slightly. Tip the sausagemeat, lemon zest, breadcrumbs, apricots, chestnuts and thyme into a bowl. Add the onion and cranberries, and mix everything together with your hands, adding plenty of pepper and a little salt.",
                "Cut each chicken breast into three fillets lengthwise and season all over with salt and pepper. Heat the remaining oil in the frying pan, and fry the chicken fillets quickly until browned, about 6-8 mins.",
                "Roll out two-thirds of the pastry to line a 20-23cm springform or deep loose-based tart tin. Press in half the sausage mix and spread to level. Then add the chicken pieces in one layer and cover with the rest of the sausage. Press down lightly.",
                "Roll out the remaining pastry. Brush the edges of the pastry with beaten egg and cover with the pastry lid. Pinch the edges to seal, then trim. Brush the top of the pie with egg, then roll out the trimmings to make holly leaf shapes and berries. Decorate the pie and brush again with egg.",
                "Set the tin on a baking sheet and bake for 50-60 mins, then cool in the tin for 15 mins. Remove and leave to cool completely. Serve with a winter salad and pickles."]
              )
    ]
}

