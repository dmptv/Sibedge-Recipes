//
//  Recipe.swift
//  Sibedge-Recipes
//
//  Created by 123 on 18.06.2018.
//  Copyright © 2018 kanat. All rights reserved.
//

import Foundation

struct Recipe {
    var name: String
    var description: String
    var instructions: String
    var difficulty: Int
    var images: [String]
    var lastUpdated: Date
    
    static func createRecipe(json: Json) -> Recipe {
        return Recipe(name:  json["name"] as? String ?? "",
               description: json["description"] as? String ?? "",
               instructions: json["instructions"] as? String ?? "",
               difficulty: json["difficulty"] as? Int ?? 0,
               images: json["images"] as? [String] ?? [""],
               lastUpdated: (json["lastUpdated"] as? Double ?? 0).dateFromTimestamp())
    }

    static var mockRecipe: Recipe {
        return Recipe(name: "Chicken ",
                      description: "Chicken with lemon, garlic, green beans and red potatoes, Chicken with lemon, garlic, green beans and red potatoes, Chicken with lemon, garlic, green beans and red potatoes. End of description",
                      instructions: "1. Preheat the oven to 230deg C. Coat a large baking dish or cast-iron skillet with 1 tbs of olive oil. Arrange the lemon slices in a single layer in the bottom of the dish or skillet.<br>2. In a large bowl, combine the remaining oil, lemon juice, garlic, salt and pepper; add the green beans and toss to coat. Using a slotted spoon or tongs, remove the green beans and arrange them on top of the lemon slices. Add the potatoes to the same olive oil mixture and toss to coat. Using a slotted spoon or tongs, arrange the potatoes along the inside edge of the dish or skillet on top of the green beans. Place the chicken in the same bowl with the olive oil mixture and coat thoroughly. Place the chicken, skin side up, in the dish or skillet. Pour any remaining olive oil mixture over the chicken.<br>3. Roast for 50 minutes. Remove the chicken from the dish or skillet. Place the beans and potatoes back in the oven for 10 minutes more or until the potatoes are tender.<br>4. Place a chicken breast on each of 4 serving plates; divide the green beans and potatoes equally. Serve warm. End of instructions",
                      difficulty: 5,
                      images: [
                        "https://bigoven-res.cloudinary.com/image/upload/t_recipe-256/roasted-chicken-with-whole-lemon-an.jpg",
                               "https://bigoven-res.cloudinary.com/image/upload/t_recipe-256/roasted-chicken-with-whole-lemon-an-2.jpg",
                               "https://bigoven-res.cloudinary.com/image/upload/t_recipe-256/minted-orzo-with-tomatoes-30dc99.jpg"
            ],
                      lastUpdated: Date())
    }
}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        
        return dateFormatter.string(from: date)
    }
    
    func dateFromTimestamp() -> Date {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeZone = TimeZone.current
        
        return date
    }
    
}























