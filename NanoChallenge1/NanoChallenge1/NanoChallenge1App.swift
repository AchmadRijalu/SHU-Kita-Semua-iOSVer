//
//  NanoChallenge1App.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 02/05/23.
//

import SwiftUI

@main
struct NanoChallenge1App: App {
    @StateObject var anggotaListTambah = AnggotaList()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(anggotaListTambah)
        }
    }
}