//
//  FacultyView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct FacultyView: View {
    
    var faculty: FacultyEntity
    
    var body: some View {
        TabView {
            Text("Batch")
                .tabItem {
                    Text("Batch")
                }
            Text("Teacher")
                .tabItem {
                    Text("Teacher")
                }
            Text("Course Schedule")
                .tabItem {
                    Text("Course Schedule")
                }
            Text("Employee")
                .tabItem {
                    Text("Employee")
                }
        }
        .navigationTitle(faculty.shortTitle)
    }
}

struct FacultyView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyView(faculty: FacultyEntity.example2())
    }
}
