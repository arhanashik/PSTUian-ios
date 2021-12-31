//
//  HomeView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2021/11/25.
//

import SwiftUI

struct HomeView: View {
    
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
                        leading: SignInButton(),
                        trailing: NotificationButton()
                    )
                }) //: SCROLL
            } //: NAVIGATION
        } //: GEOMETRY
    }
}

struct ProfileButton: View {
    var body: some View {
        NavigationLink(destination: SignInView(), label: {
            Image("img_placeholder_profile")
                .resizable()
                .frame(width: 28, height: 28)
                .cornerRadius(14)
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
