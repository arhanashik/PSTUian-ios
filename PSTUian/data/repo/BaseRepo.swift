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
    
    func getAll(url: String, page: Int, completion: @escaping(Result<[Entity], RepoError>) -> Void) {
        let url = URL(string: url)
        let paging = Paging(page: page, limit: 20)
        service.get([Entity].self, url: url, param: paging) { result in
            switch result {
                case .failure(let error):
                completion(Result.failure(RepoError.apiError(error: error)))
                    print(error)
                case .success(let data):
                    completion(Result.success(data))
            }
        }
    }
    
    func getKeyChain<T: Codable>(_ service: String, account: String = Key.KeyChain.Account.PSTUIAN, type: T.Type) -> T? {
        return KeychainHelper.standard.read(service: service, account: account, type: type)
    }
    
    func saveKeyChain<T: Codable>(_ item: T, service: String, account: String = Key.KeyChain.Account.PSTUIAN) -> Bool {
        return KeychainHelper.standard.save(item, service: service, account: account)
    }
    
    func deleteKeyChain(service: String, account: String = Key.KeyChain.Account.PSTUIAN) -> Bool {
        return KeychainHelper.standard.delete(service: service, account: account)
    }
}
