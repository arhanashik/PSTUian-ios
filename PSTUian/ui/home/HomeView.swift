//
//  HomeView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/11/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var authVM: AuthVM = AuthVM()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(alignment: .leading, spacing: 0) {
                        // Sliders
                        SlidersView(proxy: geometry)
                        
                        // Faculites
                        SectionTitle(title: "Faculties")
                        FacultyListView(proxy: geometry)
                        
                        // Information Corner
                        SectionTitle(title: "Information Corner")
                        InformationCornerListView(proxy: geometry)
                        
                        // Options
                        SectionTitle(title: "Options")
                        OptionsListView(proxy: geometry)
                    } //: VSTACK
                    .navigationTitle("PSTUian")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarItems(
                        leading: VStack {
                            if authVM.signInStudent != nil {
                                ProfileButton(imageUrl: authVM.signInStudent?.imageUrl)
                            } else if authVM.signInTeacher != nil {
                                ProfileButton(imageUrl: authVM.signInTeacher?.imageUrl)
                            } else {
                                SignInButton()
                            }
                        },
                        trailing: NotificationButton()
                    )
                }) //: SCROLL
            } //: NAVIGATION
            .environmentObject(authVM)
        } //: GEOMETRY
    }
}

struct ProfileButton: View {
    
    let imageUrl: String?
    var body: some View {
        NavigationLink(destination: ProfileView(), label: {
            if imageUrl == nil || imageUrl!.isEmpty {
                Image("img_placeholder_profile")
                    .resizable()
                    .frame(width: 28, height: 28)
                    .cornerRadius(14)
            } else {
                AsyncImage(url: URL(string: imageUrl!)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 28, height: 28)
                            .cornerRadius(14)
                    } else if phase.error != nil {
                        Image("img_placeholder_profile")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .cornerRadius(14)
                    } else {
                        ProgressView()
                            .frame(width: 28, height: 28)
                            .foregroundColor(.white)
                            .background(.gray)
                            .cornerRadius(14)
                    }
                }
            }
        })
    }
}

struct SignInButton: View {
    var body: some View {
        NavigationLink(destination: SignInView(), label: {
            Text("Sign In")
                .foregroundColor(primaryColor)
        })
    }
}

struct NotificationButton: View {
    var body: some View {
        NavigationLink(destination: NotificationView(), label: {
            Image(systemName: "bell.fill")
                .foregroundColor(.black)
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
