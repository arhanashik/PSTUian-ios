//
//  SliderVM.swift
//  PSTUian
//
//  Created by Md Hasnain on 2021/12/28.
//

import SwiftUI

class SliderVM: BaseVM<SliderEntity> {
    
    convenience init(repo: SliderRepo = SliderRepo()) {
        self.init(repo)
        getAll(url: Api.Slider.GetAll)
    }
    
    //MARK: preview helpers
    static func errorState() -> SliderVM {
        let vm = SliderVM()
        vm.errorMessage = ApiError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return vm
    }
    
    static func successState() -> SliderVM {
        let vm = SliderVM()
        vm.data = [SliderEntity.example1(), SliderEntity.example2(), SliderEntity.example3()]
        return vm
    }
}
