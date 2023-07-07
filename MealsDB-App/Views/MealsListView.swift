//
//  MealsListView.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/3/23.
//

import SwiftUI

struct MealsListView: View {
    @EnvironmentObject var model: MealModel
    @State private var meals: [Meal] = []
    @State private var showingModalSheet = false
    @State private var selectedItemID: String?
    
    var body: some View {
        NavigationView {
            //displays list of meals, when a meal is tapped goes to detail view
            List(meals) { meal in
                NavigationLink(
                    destination: MealsDetailView(mealID: meal.mealId)
                ) {
                    MealCell(imageURL: meal.thumbnail, name: meal.name)
                }
            }
            .navigationTitle("Desserts")
        }
        
        .onAppear {
            //fetches list of meals from model
            model.fetchMealData(completion: { data in
                meals = data.meals
                
                
            })
        }
    }
}
