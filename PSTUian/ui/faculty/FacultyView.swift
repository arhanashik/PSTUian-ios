//
//  FacultyView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

enum FacultyTab: String {
    case batch = "Batch"
    case teacher = "Teacher"
    case course = "Course"
    case employee = "Employee"
}

struct FacultyView: View {
    
    var faculty: FacultyEntity
    @State var tab: FacultyTab = FacultyTab.batch
    
    var body: some View {
        VStack {
            TabSelector(tab: $tab)
                .padding(.horizontal)
            TabView(selection: $tab) {
                BatchListView(faculty: faculty)
                    .tabItem {
                        Text(FacultyTab.batch.rawValue)
                    }
                    .tag(FacultyTab.batch)
                Text("Teacher")
                    .tabItem {
                        Text(FacultyTab.teacher.rawValue)
                    }
                    .tag(FacultyTab.teacher)
                Text("Course Schedule")
                    .tabItem {
                        Text(FacultyTab.course.rawValue)
                    }
                    .tag(FacultyTab.course)
                Text("Employee")
                    .tabItem {
                        Text(FacultyTab.employee.rawValue)
                    }
                    .tag(FacultyTab.employee)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .navigationTitle(faculty.shortTitle)
    }
}

struct TabSelector: View {
    
    @Binding var tab: FacultyTab
    
    var body: some View {
        Picker(selection: $tab, label: Text("Menu")) {
            Text(FacultyTab.batch.rawValue).tag(FacultyTab.batch)
            Text(FacultyTab.teacher.rawValue).tag(FacultyTab.teacher)
            Text(FacultyTab.course.rawValue).tag(FacultyTab.course)
            Text(FacultyTab.employee.rawValue).tag(FacultyTab.employee)
        }
        .pickerStyle(.segmented)
    }
}

struct FacultyView_Previews: PreviewProvider {
    static var previews: some View {
        FacultyView(faculty: FacultyEntity.example2())
    }
}
