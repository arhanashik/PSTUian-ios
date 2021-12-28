//
//  SectionTitle.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct SectionTitle: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(color4B4B4B)
            .padding(.leading)
    }
}
