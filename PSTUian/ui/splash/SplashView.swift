//
//  SplashView.swift
//  PSTUian
//
//  Created by Arhan Ashik on 2022/01/02.
//

import SwiftUI

// SplashView WorkFlow
// 1. Run Splash Animation and wait(until splash time ends)
// 2. register/update device
// 3. clear necessary cache data
// 4. check for update
// 5. request for app config
//  5.1. refresh data if necessary
// 6. show HomeView
struct SplashView: View {
    
    @StateObject var vm = SplashVM()
    
    var body: some View {
        VStack {
            if vm.isActive {
                SplashContentView(showLoader: $vm.isLoading)
            } else {
                HomeView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation {
                    vm.registerDevice()
                }
            }
        }
        .alert(item: $vm.alertItem, content: { alertItem in
            Alert(
                title: alertItem.title,
                message: alertItem.message,
                dismissButton: .default(alertItem.buttonTitle, action: {
                    alertItem.action()
                })
            )
        })
    }
}

struct SplashContentView: View {
    
    @Binding var showLoader: Bool
    var body: some View {
        ZStack {
            AppLogo()
            VStack {
                Spacer()
                if showLoader {
                    LoadingView()
                        .padding(.bottom, 100)
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
