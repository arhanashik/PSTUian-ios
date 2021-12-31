//
//  SignInView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/29.
//

import SwiftUI

struct SignInView: View {
    
    @State var userType: String = UserType.STUDENT
    @State var email: String = ""
    @State var passowrd: String = ""
    
    var body: some View {
        VStack {
            AppLogo()
            UserTypeSelector(userType: $userType)
            EmailInput(email: $email)
            PasswordInput(passowrd: $passowrd)
            HStack {
                Button(action: {email = "ashik.pstu.cse"}) {
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
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
