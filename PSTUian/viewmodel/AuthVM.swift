//
//  AuthVM.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

class AuthVM: ObservableObject {
    
    @Published var signInStudent: StudentEntity? = nil
    @Published var signInTeacher: TeacherEntity? = nil
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertItem?
    
    let repo: AuthRepo
    init(repo: AuthRepo = AuthRepo()) {
        self.repo = repo
        getSignInUser()
    }
    
    func registerDevice() {
        
    }
    
    func signIn(userType: UserType, email: String, password: String) {
        if userType == .student {
            signInStudent(email: email, password: password)
        } else {
            signInTeacher(email: email, password: password)
        }
    }
    
    private func signInStudent(email: String, password: String) {
        isLoading = true
        self.alertItem = AlertContext.loading
        repo.signInStudent(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.alertItem = AlertContext.error
                    self.alertItem?.message = Text(error.localizedDescription)
                case .success(let data):
                    self.signInStudent = data
                    self.alertItem = AlertContext.success
                    self.alertItem?.message = Text("Signed in as \(data.name)")
                }
            }
        }
    }
    
    private func signInTeacher(email: String, password: String) {
        isLoading = true
        self.alertItem = AlertContext.loading
        repo.signInTeacher(email: email, password: password) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.alertItem = AlertContext.error
                    self.alertItem?.message = Text(error.localizedDescription)
                case .success(let data):
                    self.signInTeacher = data
                    self.alertItem = AlertContext.success
                    self.alertItem?.message = Text("Signed in as \(data.name)")
                }
            }
        }
    }
    
    func getSignInUser() {
        
        guard let userType = repo.getSignInUserType() else {
            return
        }
        
        signInStudent = nil
        signInTeacher = nil
        if userType == .student {
            signInStudent = repo.getSignInStudent()
        } else if userType == .teacher {
            signInTeacher = repo.getSignInTeacher()
        }
    }
    
    func signOut() {
        if repo.deleteSignInUser() {
            signInStudent = nil
            signInTeacher = nil
        }
    }
}
