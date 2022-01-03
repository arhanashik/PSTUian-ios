//
//  ForgotPasswordView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var userType: UserType = UserType.student
    @State var email: String = ""
    
    var body: some View {
        VStack {
            AppLogo()
            UserTypeSelector(userType: $userType)
            EmailInput(email: $email)
            HStack {
                Button(action: {email = "ashik.pstu.cse"}) {
                    ActionButton(title: "SEND")
                }
                Spacer()
            }
            Text("*Password reset instructions will be sent to your email address")
                .foregroundColor(color4B4B4B)
            DividerOr()
            Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                LabelButton(label: "Remember Password?", buttonTitle: "Sign In")
            }
        }
        .padding()
        .navigationTitle("Forgot Password")
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
