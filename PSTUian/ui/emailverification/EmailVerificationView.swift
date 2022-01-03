//
//  EmailVerificationView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/12/31.
//

import SwiftUI

struct EmailVerificationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var userType: UserType = UserType.student
    @State var email: String = ""
    
    var body: some View {
        VStack {
            AppLogo()
            UserTypeSelector(userType: $userType)
            EmailInput(email: $email)
            HStack {
                Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                    ActionButton(title: "SEND")
                }
                Spacer()
            }
            Text("*A verification link will be sent to your email address. Check spam folder if you cannot find it.")
                .foregroundColor(color4B4B4B)
            DividerOr()
            Button (action: { self.presentationMode.wrappedValue.dismiss() }) {
                LabelButton(label: "Already Verified?", buttonTitle: "Sign In")
            }

        }
        .padding()
        .navigationTitle("Email Verification")
    }
}

struct EmailVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        EmailVerificationView()
    }
}
