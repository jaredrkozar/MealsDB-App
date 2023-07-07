//
//  MealInfo.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/5/23.
//

import SwiftUI

struct MealInfoArray: Decodable {
    //decodes the meals array from the API
    var meals: [MealInfo]
}

struct MealInfo: Decodable {
    var name: String
    var thumbnail: String
    var country: String
    var instructions: [String]
    var ingredients: [String]
    
    enum InnerCodingKeys: String, CodingKey {
        case name = "strMeal"
        case thumbnail = "strMealThumb"
        case country = "strArea"
        case instructions = "strInstructions"
    }
    
    struct CustomCodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            self.intValue = intValue
            self.stringValue = "\(intValue)"
        }
        
    }
    init(from decoder: Decoder) throws {
        //decodes meal data (name, thumbnail, id etc)
        let container = try decoder.container(keyedBy: InnerCodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        thumbnail = try container.decode(String.self, forKey: .thumbnail)
        country = try container.decode(String.self, forKey: .country)
        let allInstructions = try container.decode(String.self, forKey: .instructions)
        let withoutR = allInstructions.replacingOccurrences(of: "\r", with: "")
        let withoutN = withoutR.replacingOccurrences(of: "\n", with: "")
        instructions = withoutN.components(separatedBy: ". ")
        
        let ingredientsList = try decoder.container(keyedBy: CustomCodingKeys.self)
        
        var ingredientsArray: [String] = []
        
        for i in 1..<20 {
            guard let ingredientKey = CustomCodingKeys(stringValue:  "strIngredient\(i)"), let measureKey = CustomCodingKeys(stringValue:  "strMeasure\(i)") else { continue }
            
            let measurement = try ingredientsList.decodeIfPresent(String.self, forKey: measureKey)
            
            let ingredient = try ingredientsList.decodeIfPresent(String.self, forKey: ingredientKey)
            
            if measurement?.count != 0 && ingredient?.count != 0 {
                ingredientsArray.append("\(measurement!) of \(ingredient!)")
            }
        }
        
        ingredients = ingredientsArray
    }
}
