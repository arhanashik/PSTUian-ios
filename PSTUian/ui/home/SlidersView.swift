//
//  SlidersView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct SlidersView: View {
    
    var proxy: GeometryProxy
    @StateObject var sliderVM = SliderViewModel()
    
    var body: some View {
        if sliderVM.isLoading {
            LoadingView()
                .frame(width: proxy.size.width, height: 260)
        } else if sliderVM.errorMessage != nil {
            ErrorView(errorMessage: sliderVM.errorMessage!)
                .frame(width: proxy.size.width, height: 260)
        } else if sliderVM.sliders.isEmpty {
            ErrorView(errorMessage: "No Data")
                .frame(width: proxy.size.width, height: 260)
        } else {
            ImageSliderView(sliders: sliderVM.sliders)
                .frame(height: 260)
        }
    }
}
