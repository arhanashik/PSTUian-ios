//
//  HomeView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical, showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: 0) {
                    HeaderView()
                    
                    ImageSliderView(sliders: dummySliders)
                        .frame(height: 260)
                    
                    SectionTitle(title: "Faculties")
                } //: VSTACK
            }) //: SCROLL
        } //: GEOMETRY
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("PSTUian")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(primaryColor)
            
            Spacer()
            
            Text("Sign In")
                .font(.body)
                .padding(.horizontal)
            
            Image(systemName: "bell.fill")
        } //: HSTACK
        .padding(.horizontal)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct SectionTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(color4B4B4B)
            .padding(.leading)
    }
}
