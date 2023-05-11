//
//  SHUAnggotaPage.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 05/05/23.
//

import SwiftUI

struct SHUAnggotaPage: View {
    @State private var searchText = ""
    @State var anggotaListDataSaved : [AnggotaModel] = UserDefaults.standard.retrieveCodable(for: "anggotaUserDefaultKey") ?? []
    @State var getSHUModel:[SHUModel]?
    

    @State  var getAnggotData = AnggotaModel(name: "", pembelian: 0, simpanan: 0)
    
    var body: some View {
//        var setSHUData:SHUModel {
//          var  shuData = SHUModel(name: "", SHU: 0)
//
//        }
        GeometryReader{reader in
            NavigationStack{
                ScrollView{
                    VStack{

                        ForEach(anggotaListDataSaved, id: \.id) { anggota in
                            //declare the object of each anggota

                            //hitung jasa modal
                          var jasaModal:Double = (getAnggotData.pembelian + getAnggotData.simpanan)
                            
                            Text(anggotaListDataSaved[2].pembelian.description)
                            
                                    }
                    }.padding([.leading, .trailing], 20)
                }
                .navigationTitle("SHU Anggota")
                
            }.searchable(text: $searchText)
        }
    }
}

struct SHUAnggotaPage_Previews: PreviewProvider {
    
    static var getSHUModel: [SHUModel] = []
    static var previews: some View {
        SHUAnggotaPage(getSHUModel: getSHUModel)
    }
}
