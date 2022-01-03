//
//  AuthRepo.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

class AuthRepo {
    
    let service: ApiServiceProtocol
    let deviceRepo: DeviceRepo
    init(serive: ApiServiceProtocol = ApiService(), deviceRepo: DeviceRepo = DeviceRepo()) {
        self.service = serive
        self.deviceRepo = deviceRepo
    }
    
    func saveAuthToken(_ authToken: String) -> Bool {
        return saveKeyChain(authToken, service: Key.KeyChain.AUTH_TOKEN)
    }
    
    func getAuthToken() -> String? {
        return getKeyChain(Key.KeyChain.AUTH_TOKEN, type: String.self)
    }
    
    func signInStudent(email: String, password: String, completion: @escaping(Result<StudentEntity, RepoError>) -> Void) {
        let url = URL(string: Api.Auth.SignIn)
        guard let device = deviceRepo.getDevice() else {
            completion(Result.failure(RepoError.localError(error: "Invalid device!")))
            return
        }
        let params = SignInParams(userType: UserType.student.rawValue, email: email, password: password, deviceId: device.id)
        service.auth(StudentEntity.self, url: url, param: params) { result in
            switch result {
                case .failure(let error):
                print(error)
                completion(Result.failure(RepoError.apiError(error: error)))
                case .success(let response):
                if self.storeSignInUser(response.data, .student) && self.saveAuthToken(response.authToken!) {
                    completion(Result.success(response.data!))
                } else {
                    // Failed to store device
                    completion(Result.failure(RepoError.localError(error: "Could not complete sign in!")))
                }
            }
        }
    }
    
    func signInTeacher(email: String, password: String, completion: @escaping(Result<TeacherEntity, RepoError>) -> Void) {
        let url = URL(string: Api.Auth.SignIn)
        guard let device = deviceRepo.getDevice() else {
            completion(Result.failure(RepoError.localError(error: "Invalid device!")))
            return
        }
        let params = SignInParams(userType: UserType.teacher.rawValue, email: email, password: password, deviceId: device.id)
        service.auth(TeacherEntity.self, url: url, param: params) { result in
            switch result {
                case .failure(let error):
                print(error)
                completion(Result.failure(RepoError.apiError(error: error)))
                case .success(let response):
                if self.storeSignInUser(response.data, .teacher) && self.saveAuthToken(response.authToken!) {
                    completion(Result.success(response.data!))
                } else {
                    // Failed to store device
                    completion(Result.failure(RepoError.localError(error: "Could not complete sign in!")))
                }
            }
        }
    }
    
    func storeSignInUser<T: Codable>(_ user: T, _ userType: UserType) -> Bool {
        return saveKeyChain(user, service: Key.KeyChain.USER) && saveKeyChain(userType.rawValue, service: Key.KeyChain.USER_TYPE)
    }
    
    func getSignInUserType() -> UserType? {
        let userType = getKeyChain(Key.KeyChain.USER_TYPE, type: String.self)
        if userType == UserType.student.rawValue {
            return .student
        } else if userType == UserType.teacher.rawValue {
            return .student
        }
        
        return nil
    }
    
    func deleteSignInUser() -> Bool {
        return deleteKeyChain(service: Key.KeyChain.USER) && deleteKeyChain(service: Key.KeyChain.USER_TYPE)
    }
    
    func getSignInStudent() -> StudentEntity? {
        return getKeyChain(Key.KeyChain.USER, type: StudentEntity.self)
    }
    
    func getSignInTeacher() -> TeacherEntity? {
        return getKeyChain(Key.KeyChain.USER, type: TeacherEntity.self)
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
