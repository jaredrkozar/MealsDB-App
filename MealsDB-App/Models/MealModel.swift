//
//  MealFetcher.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/4/23.
//

import Foundation


class MealModel: ObservableObject {
    @Published var meals = [Meal]()
    @Published var selectedMealID: String?
    
    func fetchMealData(completion: @escaping(MealsArray) -> Void) {
      
      guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else { return }
      
      let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
        if let error = error {
          print("Error fetching movies: \(error.localizedDescription)")
        }
        
        guard let jsonData = data else { return }

        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MealsArray.self, from: jsonData)
            
          completion(decodedData)
        } catch {
          print("Error decoding data.")
        }
        
      }
      
      dataTask.resume()
    }
    
    func fetchMealInfo(mealID: String, completion: @escaping(MealInfo) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else { return }
        print(url)
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
          if let error = error {
            print("Error fetching movies: \(error.localizedDescription)")
          }
          
          guard let jsonData = data else { return }

          let decoder = JSONDecoder()
          
          do {
              let decodedData = try decoder.decode(MealInfoArray.self, from: jsonData)
              
              completion(decodedData.meals.first!)
          } catch {
            print("Error decoding data: \(error)")
          }
          
        }
        
        dataTask.resume()
    }
}

