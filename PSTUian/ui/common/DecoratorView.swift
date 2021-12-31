//
//  DecoratorView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

struct AppLogo: View {
    
    var width: CGFloat = 120.0
    var height: CGFloat = 120.0
    
    var body: some View {
        Image("pstulogo")
            .resizable()
            .scaledToFit()
            .frame(width: width, height: height)
            .clipped()
    }
}

struct Divider: View {
    var body: some View {
        Rectangle().fill(lightGray).frame(height: 1)
    }
}

struct DividerOr: View {
    var body: some View {
        ZStack {
            Divider()
            Text("Or")
                .font(.footnote)
                .padding(8.0)
                .foregroundColor(color4B4B4B)
                .background(
                    Circle()
                        .stroke(lightGray, lineWidth: 1)
                        .background(.white)
                )
        }.padding(.vertical, 8.0)
    }
}
