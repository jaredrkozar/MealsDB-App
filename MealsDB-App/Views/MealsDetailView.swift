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
        HStack {
            AsyncImageView(url: meal!.thumbnail, height: 70.0)
            VStack {
                Text(meal!.name)
                    .font(.title2)
                    .bold()
                
                Text(meal!.country)
                    .font(.title2)
                    .foregroundColor(.gray)
            }
        }
        
        .onAppear {
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
