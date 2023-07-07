//
//  ContentView.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/3/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var model = MealModel()
    var body: some View {
        //requires iOS 15 minimum, sowe can't use the new NavigationSplitView as its an iOS 16+ API
        
        MealsListView()
        .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
