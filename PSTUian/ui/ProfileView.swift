//
//  ProfileView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/03.
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject var authVM: AuthVM
    
    @State var title: String = "Profile"
    
    var body: some View {
        VStack {
            if authVM.signInStudent != nil {
                ProfileImage(imageUrl: authVM.signInStudent?.imageUrl)
                Spacer()
            } else if authVM.signInTeacher != nil {
                ProfileImage(imageUrl: authVM.signInTeacher?.imageUrl)
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Profile")
        .navigationBarItems(
            trailing: Button(action: { authVM.signOut() }) {
                TextButton(title: "Sign Out")
            }
        )
        .onAppear {
            if authVM.signInStudent != nil {
                title = authVM.signInStudent?.name ?? "Profile"
            } else if authVM.signInTeacher != nil {
                title = authVM.signInTeacher?.name ?? "Profile"
            }
        }
    }
}

struct ProfileImage: View {
    
    let imageUrl: String?
    let width: CGFloat = 120
    let height: CGFloat = 120
    var body: some View {
        NavigationLink(destination: ProfileView(), label: {
            if imageUrl == nil || imageUrl!.isEmpty {
                Image("img_placeholder_profile")
                    .resizable()
                    .frame(width: width, height: height)
                    .cornerRadius(width)
            } else {
                AsyncImage(url: URL(string: imageUrl!)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: width, height: height)
                            .cornerRadius(width)
                    } else if phase.error != nil {
                        Image("img_placeholder_profile")
                            .resizable()
                            .frame(width: width, height: height)
                            .cornerRadius(width)
                    } else {
                        ProgressView()
                            .frame(width: width, height: height)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(width)
                    }
                }
            }
        })
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
