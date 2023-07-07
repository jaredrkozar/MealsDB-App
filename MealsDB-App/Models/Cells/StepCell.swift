//
//  StepCell.swift
//  MealsDB-App
//
//  Created by Jared Kozar on 7/7/23.
//

import SwiftUI

struct StepCell: View {
    @State var isOn: Bool = false
    @State var text: String
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Text(text)
        }
        .toggleStyle(Checkbox())
    }
}

struct Checkbox: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()

        }, label: {
            HStack {
                Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                    .tint(configuration.isOn ? .blue : .gray)

                configuration.label
                    .tint(configuration.isOn ? .gray : .primary)
            }
        })
    }
}
