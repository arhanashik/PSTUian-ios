//
//  SignInView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct SignInView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var authVM: AuthVM
    
    @State var userType: UserType = UserType.student
    @State var email: String = ""
    @State var passowrd: String = ""
    
    var body: some View {
        VStack {
            AppLogo()
                .padding(.bottom, 16.0)
            UserTypeSelector(userType: $userType)
            EmailInput(email: $email)
            PasswordInput(passowrd: $passowrd)
            HStack {
                Button(action: { authVM.signIn(userType: userType, email: email, password: passowrd) }) {
                    ActionButton(title: "SIGN IN")
                }
                Spacer()
                NavigationLink(destination: ForgotPasswordView()) {
                    TextButton(title: "Forgot Password?")
                }
            }
            DividerOr()
            NavigationLink(destination: SignUpView()) {
                LabelButton(label: "Need new Account?", buttonTitle: "Sign Up")
            }
            DividerOr()
            NavigationLink(destination: EmailVerificationView()) {
                LabelButton(label: "Email not verified yet?", buttonTitle: "Verify Now")
            }
        }
        .padding()
        .navigationTitle("Sign In")
        .alert(item: $authVM.alertItem, content: { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: .default(alertItem.buttonTitle, action: {
                    alertItem.action()
                    if authVM.signInStudent != nil || authVM.signInTeacher != nil {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                })
            )
        })
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
