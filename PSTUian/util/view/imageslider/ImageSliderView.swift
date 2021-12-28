//
//  ImageSliderView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/02.
//

import SwiftUI

struct ImageSliderView: View {
    
    let sliders: [SliderEntity]
    
    var body: some View {
        TabView {
            ForEach(sliders) { slider in
                ImageSliderItemView(slider: slider)
                    .padding(.horizontal, 5)
            }
        } //: TAB
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .cornerRadius(8.0)
        .padding(.vertical)
        .padding(.horizontal, 11)
    }
}

struct ImageSliderView_Previews: PreviewProvider {
    static var previews: some View {
        ImageSliderView(sliders: SliderViewModel.successState().sliders)
            .background(Color.gray)
    }
}
