//
//  MealsDetailView.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/3/23.
//

import SwiftUI

struct MealsDetailView: View {
    @EnvironmentObject var model: MealModel
    @State var mealID: String
    @State private var meal: MealInfo?
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                //fetches the image for the meal asyncrounsly
                AsyncImageView(url: meal?.thumbnail, height: 90.0)
                VStack(alignment: .leading) {
                    Text(meal?.name ?? "Loading...")
                        .font(.title2)
                        .bold()
                    
                    Text(meal?.country ?? "Loading...")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
            }
            
            if meal == nil {
                Text("Loading")
            } else {
                //creates list of ingredients and steps with sections
                List {
                    Section {
                        ForEach(meal!.ingredients, id: \.self) { ingredient in
                           Text("\(ingredient)")
                       }
                      } header: {
                          Text("Ingredients for food")
                      }
                    Section {
                        ForEach(meal!.instructions, id: \.self) { instruction in
                           StepCell(text: instruction)
                       }
                      } header: {
                          Text("Steps to make food")
                      }
                    
                }
            }

        }
        .onAppear {
            //returns meal info from model
            model.fetchMealInfo(mealID: mealID) { returnedMealInfo in
                
                meal = returnedMealInfo
            }
        }
    }
}

struct MealsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MealsDetailView(mealID: "XLLX")
    }
}
