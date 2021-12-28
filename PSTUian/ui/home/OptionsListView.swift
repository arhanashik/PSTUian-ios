//
//  OptionsListView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct OptionsListView: View {
    
    var proxy: GeometryProxy
    
    var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            OptionCard(proxy: proxy, title: "Donate")
            OptionCard(proxy: proxy, title: "Need Blood?")
            OptionCard(proxy: proxy, title: "Check In")
            OptionCard(proxy: proxy, title: "Rate App")
            OptionCard(proxy: proxy, title: "Clear Data")
            OptionCard(proxy: proxy, title: "Settings")
        }.padding(15.0)
    }
}

struct OptionCard: View {
    var proxy: GeometryProxy
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(color4B4B4B)
                .padding(10.0)
        }
        .frame(width: proxy.size.width/3 - 25, height: 80)
        .background(.white)
        .cornerRadius(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(lightGray, lineWidth: 1)
        )
        .shadow(color: lightGray, radius: 5, x: 5, y: 5)
    }
}
