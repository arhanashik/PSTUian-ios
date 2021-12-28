//
//  FacultyListView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

struct FacultyListView: View {
    
    var proxy: GeometryProxy
    @StateObject var facultyVM = FacultyViewModel()
    
    var columns: [GridItem] = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
    var body: some View {
        if facultyVM.isLoading {
            LoadingView()
                .frame(width: proxy.size.width, height: 100)
        } else if facultyVM.errorMessage != nil {
            ErrorView(errorMessage: facultyVM.errorMessage!)
                .frame(width: proxy.size.width, height: 100)
        } else if facultyVM.faculties.isEmpty {
            ErrorView(errorMessage: "No Data")
                .frame(width: proxy.size.width, height: 100)
        } else {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(facultyVM.faculties) { faculty in
                    NavigationLink(destination: FacultyView(faculty: faculty)) {
                        FacultyCard(proxy: proxy, faculty: faculty)
                    }
               }
            }.padding(15.0)
        }
    }
}

struct FacultyCard: View {
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
