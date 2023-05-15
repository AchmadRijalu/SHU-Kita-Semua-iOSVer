//
//  AnggotaModel.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 07/05/23.
//

import Foundation


struct AnggotaModel:Hashable, Codable, Identifiable{
    var id = UUID()
    var name:String
    var pembelian:Double
    var simpanan:Double
}



class KoperasiSharedData: ObservableObject {
    @Published var tambahAnggotaDataSaved : [AnggotaModel] = UserDefaults.standard.retrieveCodable(for: "anggotaUserDefaultKey") ?? []
    @Published var totalSimpanan:Double = 0
    @Published var totalPembelian:Double = 0
    @Published var count:Bool = false
    @Published var koperasiDataSaved : KoperasiModel = UserDefaults.standard.retrieveCodable(for: "koperasiUserDefaultKey") ?? KoperasiModel(SHUData: 250000, jasaModal: 20, jasaAnggota: 25)
}
