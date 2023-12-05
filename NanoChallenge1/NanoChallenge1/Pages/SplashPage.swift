//
//  Splash.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 16/05/23.
//

import SwiftUI

struct SplashPage: View {
    @State private var isActive = false
    @State private var size = 0.9
    @State private var opacity = 0.5
    var body: some View {
        
        if isActive == true{
            ContentView()
        }
        else{
            VStack{
                VStack{
                    Image("logo")
                }.scaleEffect(size).opacity(opacity).onAppear(){
                    withAnimation(.easeIn(duration: 1.4)){
                        self.size = 0.9
                        self.opacity = 1.0
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color("PrimaryColor")).onAppear(){
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    withAnimation(){
                        self.isActive = true
                    }
                   
                }
            }
        }
        
    }
}

struct SplashPage_Previews: PreviewProvider {
    static var previews: some View {
        SplashPage()
    }
}
