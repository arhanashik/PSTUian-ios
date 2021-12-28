//
//  ImageSliderItemView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/02.
//

import SwiftUI

struct ImageSliderItemView: View {
    
    let slider: SliderEntity
    
    var body: some View {
        GeometryReader { geometry in
            if(!slider.imageUrl.isEmpty) {
                AsyncImage(url: URL(string: slider.imageUrl)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width)
                            .cornerRadius(8.0)
                            .clipped()
                            .overlay(OverlayTitle(title: slider.title), alignment: .top)
                    } else if phase.error != nil {
                        ErrorPlaceholder(errorMessage: phase.error?.localizedDescription ?? "Image Not Found")
                            .frame(width: geometry.size.width)
                    } else {
                        ProgressView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(8.0)
                    }
                }
            } else {
                Color.gray
                    .cornerRadius(8.0)
                    .frame(width: geometry.size.width)
            }
            
//            Image(slider.imageUrl)
//                .resizable()
//                .scaledToFill()
//                .frame(width: geometry.size.width)
//                .cornerRadius(8.0)
//                .clipped()
//                .overlay(OverlayTitle(title: slider.title), alignment: .bottom)
        }
    }
}

struct ErrorPlaceholder: View {
    var errorMessage: String
    var body: some View {
        Text(errorMessage)
            .font(.callout)
            .padding(6)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(.white)
            .background(Color.gray)
            .cornerRadius(8.0)
    }
}

struct OverlayTitle: View {
    var title: String
    var body: some View {
        ZStack {
            Text(title)
                .font(.callout)
                .padding(5)
                .foregroundColor(.white)
        }
        .background(Color.black)
        .opacity(0.6)
        .cornerRadius(8.0)
        .padding(5.0)
    }
}

struct ImageSliderItemView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSliderItemView(slider: SliderEntity.example1())
            .previewLayout(.fixed(width: 600, height: 300))
    }
}
