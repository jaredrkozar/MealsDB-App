//
//  Extensions.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/7/23.
//

import Foundation
import SwiftUI

struct AsyncImageView: View {
    var urlString: String?
    var dimension: CGFloat?
    
    init(url: String?, height: CGFloat) {
        //user inputs the url they want the image from and the height/width (same since its a square
        self.urlString = url
        self.dimension = height
    }

    var body: some View {
        //fetches the image asynchrounsly
        AsyncImage(url: URL(string: urlString ?? "")) { image in
            image.resizable()
                .frame(width: dimension, height: dimension, alignment: .leading)
                .cornerRadius(8.0)
        } placeholder: {
            //displays progress view if the image is loading
            ProgressView().progressViewStyle(.circular)
        }
    }
    
}
