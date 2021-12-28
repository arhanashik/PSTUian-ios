//
//  SliderViewModel.swift
//  PSTUian
//
//  Created by Md Hasnain on 2021/12/28.
//

import SwiftUI

class SliderViewModel: ObservableObject {
    @Published var sliders = [SliderEntity]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let sliderService: SliderApiServiceProtocol
    
    init(sliderService: SliderApiServiceProtocol = SliderApiService()) {
        self.sliderService = sliderService
        getSliders()
    }
    
    func getSliders() {
        isLoading = true
        
        let url = URL(string: SLIDER_API_URL)
        sliderService.getSliders(url: url) { [unowned self] result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let sliders):
                    self.sliders = sliders
                }
            }
        }
    }
    
    //MARK: preview helpers
    static func errorState() -> SliderViewModel {
        let vm = SliderViewModel()
        vm.errorMessage = ApiError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return vm
    }
    
    static func successState() -> SliderViewModel {
        let vm = SliderViewModel()
        vm.sliders = [SliderEntity.example1(), SliderEntity.example2(), SliderEntity.example3()]
        return vm
    }
}
