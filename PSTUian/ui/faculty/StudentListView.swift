//
//  StudentsView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/04.
//

import SwiftUI

struct StudentListView: View {
    
    let faculty: FacultyEntity
    let batch: BatchEntity
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationTitle(batch.name)
    }
}

struct StudentListItemCard: View {
    var proxy: GeometryProxy
    var faculty: FacultyEntity
    
    var body: some View {
        VStack {
            Text(faculty.shortTitle)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color4B4B4B)
        }
        .frame(width: proxy.size.width/3 - 25, height: proxy.size.width/5)
        .background(.white)
        .cornerRadius(8.0)
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(lightGray, lineWidth: 1)
        )
        .shadow(color: lightGray, radius: 5, x: 5, y: 5)
    }
}

struct StudentsView_Previews: PreviewProvider {
    static var previews: some View {
        StudentListView(faculty: FacultyEntity.example1(), batch: BatchEntity.example1())
    }
}
