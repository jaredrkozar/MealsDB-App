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
        //custom CodingKey struct so I could retreieve the ingradient and measurement correctly
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
        //gets the instructions from the instructions item
        let allInstructions = try container.decode(String.self, forKey: .instructions)
        //filters out random characters present in the instructions, such as \r and \n, and seperates the instructions into an array seperated by sentences
        
        let withoutR = allInstructions.replacingOccurrences(of: "\r", with: "")
        let withoutN = withoutR.replacingOccurrences(of: "\n", with: "")
        instructions = withoutN.components(separatedBy: ". ")
        
        //ingradients list via a custom coding key
        let ingredientsList = try decoder.container(keyedBy: CustomCodingKeys.self)
        
        //defines empty ingredients array
        var ingredientsArray: [String] = []
        
        for i in 1..<20 {
            //defines custom keys for ingredient and measurement
            guard let ingredientKey = CustomCodingKeys(stringValue:  "strIngredient\(i)"), let measureKey = CustomCodingKeys(stringValue:  "strMeasure\(i)") else { continue }
            
            //decodes measurement if present in the json
            let measurement = try ingredientsList.decodeIfPresent(String.self, forKey: measureKey)
            
            //decodes ingredient if present in the json
            let ingredient = try ingredientsList.decodeIfPresent(String.self, forKey: ingredientKey)
            
            //if the measurement is not an empty string and its not nil (and if the ingradient is not an empty string and not nil then append it to the array
            if (measurement?.count != 0 && measurement != nil) && (ingredient?.count != 0 && ingredient != nil) {
                ingredientsArray.append("\(measurement!) of \(ingredient!)")
            }
        }
        //set ingredients equal to array
        ingredients = ingredientsArray
    }
}
