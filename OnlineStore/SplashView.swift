//
//  SplashView.swift
//  OnlineStore
//
//  Created by dev on 3/12/23.
//

import SwiftUI



struct SplashView: View {
    
    // 1.
    @State var isActive:Bool = false
    
    var body: some View {
        VStack {
            // 2.
            if self.isActive {
                // 3.
                HomeView(productsList: [])
            } else {
                // 4.
                Image("Product-Color")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
//                Text("Online Store")
//                    .font(.system(size: 24))
            }
        }
        // 5.
        .onAppear {
            // 6.
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // 7.
                withAnimation {
                    self.isActive = true
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
