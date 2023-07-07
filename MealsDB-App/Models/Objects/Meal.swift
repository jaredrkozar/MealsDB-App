//
//  Meal.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/4/23.
//

import Foundation

//don't need to encode to json, so we don't need to conform to Encodable

struct MealsArray: Decodable {
    //decodes the meals array from the API
    var meals: [Meal]
}

struct Meal: Decodable, Identifiable {
    //easier for me to use name, thumbnail etc instead of strMeal, strThumbnail etc so i defined custom CodingKeys and decoded from those
    var name: String
    var thumbnail: String
    var mealId: String
    var id: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case mealId = "idMeal"
    }
    
    init(from decoder: Decoder) throws {
        //decodes meal data (name, thumbnail, id etc)
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        mealId = try container.decode(String.self, forKey: .mealId)
        id = Int(mealId)!
        
    }
}
