//
//  KoperasiModel.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 07/05/23.
//

import Foundation

struct KoperasiModel:Identifiable,Codable,Hashable{
    let id = UUID()
    var SHUData:Double
    var jasaModal:Double
    var jasaAnggota:Double
}


extension UserDefaults {
    func storeCodable<T: Codable>(_ object: T, key: String) {
        do {
            let data = try JSONEncoder().encode(object)
            UserDefaults.standard.set(data, forKey: key)
            UserDefaults.standard.synchronize()
        } catch let error {
            print("Error encoding: \(error)")
        }
    }
    
    func retrieveCodable<T: Codable>(for key: String) -> T? {
        do {
            guard let data = UserDefaults.standard.data(forKey: key) else {
                return nil
            }
            UserDefaults.standard.synchronize()
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            print("Error decoding: \(error)")
            return nil
        }
    }
}

