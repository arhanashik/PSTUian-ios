//
//  ImageSliderItemView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/02.
//

import SwiftUI

struct ImageSliderItemView: View {
    
    let slider: Slider
    
    var body: some View {
        GeometryReader { geometry in
            Image(slider.image)
                .resizable()
                .frame(width: geometry.size.width)
                .cornerRadius(8.0)
        }
    }
}

struct ImageSliderItemView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSliderItemView(slider: dummySliders.first!)
            .previewLayout(.sizeThatFits)
    }
}
