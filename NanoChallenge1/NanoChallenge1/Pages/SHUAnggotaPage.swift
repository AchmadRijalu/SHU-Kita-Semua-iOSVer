//
//  SHUAnggotaPage.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 05/05/23.
//

import SwiftUI

struct SHUAnggotaPage: View {
    @State private var searchText = ""
    
    @State var getSHUModel:[SHUModel]?
    @State  var getAnggotData = AnggotaModel(name: "", pembelian: 0, simpanan: 0)
    @EnvironmentObject var koperasiSharedData:KoperasiSharedData
    @State var shuListData:[SHUModel]?
    
    @State var totalSHU:Double = 0
    @State var count:Int = 0
    @State private var isLooped = false
    
    var filteredNameSHU: [AnggotaModel] {
        // If you want to return no items when there is no matching filter use this:
        koperasiSharedData.tambahAnggotaDataSaved.filter { ($0.name.lowercased().contains(searchText.lowercased()))}
        
        // If you want the whole array unless the filter matches use this:
        let returnTestArray = koperasiSharedData.tambahAnggotaDataSaved.filter { ($0.name.lowercased().contains(searchText.lowercased()))}
        guard !returnTestArray.isEmpty else { return koperasiSharedData.tambahAnggotaDataSaved }
        return returnTestArray
    }
    
    
    var body: some View {
        GeometryReader{reader in
            NavigationStack{
                ScrollView{
                    VStack{
                        ForEach(filteredNameSHU, id: \.id) { anggotaItem in
                            
                            SHUAnggotaItem(anggotaItem: .constant(anggotaItem), totalSHU: totalSHU)
                        }.padding([.leading, .trailing], 20)
                    }
                    .navigationTitle("SHU Anggota")
                    
                }.searchable(text: $searchText, prompt: "Cari Anggota")
            }.onAppear(){
                koperasiSharedData.count = false
                koperasiSharedData.totalSimpanan = 0
                koperasiSharedData.totalPembelian = 0
                
                
                if !koperasiSharedData.count {
                    for i in 0..<$koperasiSharedData.tambahAnggotaDataSaved.count {
                        
                        @State var data:AnggotaModel = koperasiSharedData.tambahAnggotaDataSaved[i]
                        
                        
                        koperasiSharedData.totalSimpanan += data.simpanan
                        koperasiSharedData.totalPembelian += data.pembelian
                        
                    }
                    
                    koperasiSharedData.count = true
                    
                }
                
                
            }
            .environmentObject(koperasiSharedData)
        }
    }
    
    
    
    struct SHUAnggotaPage_Previews: PreviewProvider {
        
        static var getSHUModel: [SHUModel] = []
        static var previews: some View {
            SHUAnggotaPage(getSHUModel: getSHUModel).environmentObject(KoperasiSharedData())
        }
    }
}
