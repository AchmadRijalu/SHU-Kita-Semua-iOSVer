//
//  AnggotaModel.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 07/05/23.
//

import Foundation


struct AnggotaModel:Hashable, Codable, Identifiable{
    let id = UUID()
    var name:String
    var pembelian:Double
    var simpanan:Double
}



class AnggotaList: ObservableObject {
    
    @Published var tambahAnggotaDataSaved : [AnggotaModel] = UserDefaults.standard.retrieveCodable(for: "anggotaUserDefaultKey") ?? []
    
    @Published var anggotaList:[AnggotaModel] =  [
        AnggotaModel(name: "Achmad Rijalu", pembelian: 25000, simpanan: 30000)
        ,
        AnggotaModel(name: "Arya Suta", pembelian: 3000, simpanan: 30000)
        
    ]
}
