//
//  ErrorView.swift
//  PSTUian
//
//  Created by Md Hasnain on 2021/12/28.
//

import SwiftUI

struct ErrorView: View {
    var errorMessage: String
    
    var body: some View {
        Text(errorMessage)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(errorMessage: SliderVM.errorState().errorMessage ?? "")
    }
}
