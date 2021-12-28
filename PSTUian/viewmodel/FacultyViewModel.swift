//
//  FacultyViewModel.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/28.
//

import SwiftUI

class FacultyViewModel: ObservableObject {
    @Published var faculties = [FacultyEntity]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let service: ApiServiceProtocol
   
    init(service: ApiServiceProtocol = ApiService()) {
        self.service = service
        getFaculties()
    }
    
    func getFaculties() {
        isLoading = true
        
        let url = URL(string: Api.Faculty.GetAll)
        service.fetch([FacultyEntity].self, url: url) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let faculties):
                    self.faculties = faculties
                }
            }
        }
    }
}
