//
//  InformationCornerListView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct InformationCornerListView: View {
    
    var proxy: GeometryProxy
    
    var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            InformationCard(proxy: proxy, title: "Admission Support", image: "img_admission_support")
            InformationCard(proxy: proxy, title: "Our Donors", image: "img_donors")
            InformationCard(proxy: proxy, title: "Website of PSTU", image: "img_pstu_website")
            InformationCard(proxy: proxy, title: "Need Help?", image: "img_help")
        }.padding(15.0)
    }
}

struct InformationCard: View {
    var proxy: GeometryProxy
    var title: String
    var image: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.body)
                .foregroundColor(color4B4B4B)
                .padding(.leading, 10.0)
                .padding(.trailing, 5.0)
            
            Spacer()
            
            Image(image)
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(width: proxy.size.width/2 - 25, height: 80)
        .background(.white)
        .cornerRadius(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(lightGray, lineWidth: 1)
        )
        .shadow(color: lightGray, radius: 5, x: 5, y: 5)
    }
}
