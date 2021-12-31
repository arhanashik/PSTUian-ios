//
//  ButtonView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

struct ActionButton: View {
    
    let title: String
    var body: some View {
        Text(title)
            .font(.body)
            .fontWeight(.bold)
            .padding(.vertical, 10.0)
            .padding(.horizontal, 24.0)
            .foregroundColor(.white)
            .background(primaryColor)
            .cornerRadius(24.0)
    }
}

struct TextButton: View {
    
    let title: String
    var body: some View {
        Text(title)
            .font(.body)
            .foregroundColor(.black)
    }
}

struct LabelButton: View {
    
    let label: String
    let buttonTitle: String
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundColor(color4B4B4B)
            TextButton(title: buttonTitle)
        }
    }
}
