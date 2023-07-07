//
//  MealCell.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/4/23.
//

import SwiftUI

struct MealCell: View {
    var imageURL: String
    var name: String
    
    var body: some View {
        HStack {
            //asyncimage's minimum deployment target is iOS 15 so we can use it, much easier than retrieving image from url via Data(contentsOf: url) imho
            
            AsyncImageView(url: imageURL, height: 50.0)
            
            Text(name)
                .font(.title2)
        }
    }
}

struct MealCell_Previews: PreviewProvider {
    static var previews: some View {
        MealCell(imageURL: "https://cdn.britannica.com/39/7139-050-A88818BB/Himalayan-chocolate-point.jpg", name: "Pin")
    }
}
