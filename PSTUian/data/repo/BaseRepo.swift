//
//  BaseRepo.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

class BaseRepo<Entity: Codable> {
    let service: ApiServiceProtocol
   
    init(service: ApiServiceProtocol = ApiService()) {
        self.service = service
    }
    
    func fetchAll(url: String, completion: @escaping(Result<[Entity], RepoError>) -> Void) {
        let url = URL(string: url)
        service.fetch([Entity].self, url: url) { result in
            switch result {
                case .failure(let error):
                completion(Result.failure(RepoError.apiError(error: error)))
                    print(error)
                case .success(let data):
                    completion(Result.success(data))
            }
        }
    }
}
