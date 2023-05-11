//
//  ContentView.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 02/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            KoperasiPage().tabItem{
                Label("Koperasi", systemImage: "list.bullet.below.rectangle")
            }
            
            SHUAnggotaPage().tabItem{
                Label("SHU Anggota", systemImage: "banknote.fill")
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
