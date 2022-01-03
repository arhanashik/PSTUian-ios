//
//  InputView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

struct UserTypeSelector: View {
    
    @Binding var userType: UserType
    
    var body: some View {
        Picker(selection: $userType, label: Text("I am")) {
            Text("Student").tag(UserType.student)
            Text("Teacher").tag(UserType.teacher)
        }
        .pickerStyle(.segmented)
        .padding(.bottom, 10.0)
    }
}

struct EmailInput: View {
    
    @Binding var email: String
    
    var body: some View {
        TextField("Email", text: $email)
            .keyboardType(.emailAddress)
            .padding()
            .background(lightGray)
            .cornerRadius(24.0)
            .padding(.bottom, 10.0)
    }
}

struct PasswordInput: View {
    
    @Binding var passowrd: String
    
    var body: some View {
        SecureField("Password", text: $passowrd)
            .padding()
            .background(lightGray)
            .cornerRadius(24.0)
            .padding(.bottom, 10.0)
    }
}
