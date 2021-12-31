//
//  BaseVM.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

class BaseVM<Entity: Codable>: ObservableObject {
    @Published var data = [Entity]()
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let repo: BaseRepo<Entity>
   
    init(_ repo: BaseRepo<Entity> = BaseRepo(service: ApiService())) {
        self.repo = repo
    }
    
    func fetchAll(url: String) {
        isLoading = true
        
        repo.fetchAll(url: url) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(error)
                case .success(let data):
                    self.data = data
                }
            }
        }
    }
}
