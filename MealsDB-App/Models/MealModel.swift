//
//  MealFetcher.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/4/23.
//

import Foundation


class MealModel: ObservableObject {
    func fetchMealData(completion: @escaping(MealsArray) -> Void) {
        //the url to get all of the desserts
      guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
      
        //fetches json from server
      let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
          print("Error fetching movies: \(error.localizedDescription)")
        }
        
        guard let jsonData = data else { return }

        let decoder = JSONDecoder()
        
        do {
            //decodes the json data using the MealsArray struct
            let decodedData = try decoder.decode(MealsArray.self, from: jsonData)
            
        //calls completion handler
          completion(decodedData)
        } catch {
          print("Error decoding data.")
        }
        
      }
      
      dataTask.resume()
    }
    
    func fetchMealInfo(mealID: String, completion: @escaping(MealInfo) -> Void) {
        //the url to get the meals info
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { return }
        
        //fetches json from server
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
          if let error = error {
            print("Error fetching movies: \(error.localizedDescription)")
          }
          
          guard let jsonData = data else { return }

          let decoder = JSONDecoder()
          
          do {
              //decodes the json data using the MealInfoArray struct
              let decodedData = try decoder.decode(MealInfoArray.self, from: jsonData)
              
            //calls completion handler
              completion(decodedData.meals.first!)
          } catch {
            print("Error decoding data: \(error)")
          }
          
        }
        
        dataTask.resume()
    }
}

