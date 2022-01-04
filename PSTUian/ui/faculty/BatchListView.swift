//
//  BatchView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/04.
//

import SwiftUI

struct BatchListView: View {
    
    let faculty: FacultyEntity
    @StateObject var vm: BatchVM = BatchVM()
    
    var body: some View {
        VStack {
            if vm.isLoading {
                LoadingView()
            } else if vm.errorMessage != nil {
                ErrorView(errorMessage: vm.errorMessage!)
            } else if vm.data.isEmpty {
                ErrorView(errorMessage: "No Data")
            } else {
                List(vm.data) { batch in
                    NavigationLink(destination: StudentListView(faculty: faculty, batch: batch)) {
                        BatchListItemCard(batch: batch)
                    }
                }
            }
        }
        .background(.white)
        .onAppear {
            vm.getAllBatch(facultyId: faculty.id)
//            vm.isLoading = false
        }
    }
}

struct BatchListItemCard: View {
    var batch: BatchEntity
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(batch.name)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Registered Student")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(String(batch.registeredStudent))
                            .font(.footnote)
                            .foregroundColor(color4B4B4B)
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Total Student")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(String(batch.totalStudent))
                            .font(.footnote)
                            .foregroundColor(color4B4B4B)
                    }
                }
            }
            Rectangle()
                .fill(lightGray)
                .frame(width: 1)
                .padding(.horizontal, 10)
            VStack(alignment: .center) {
                Text("Session")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text(String(batch.session))
                    .font(.footnote)
                    .foregroundColor(color4B4B4B)
            }
        }
        .padding(.vertical, 10)
    }
}


struct BatchView_Previews: PreviewProvider {
    static var previews: some View {
        BatchListView(faculty: FacultyEntity.example1())
    }
}
