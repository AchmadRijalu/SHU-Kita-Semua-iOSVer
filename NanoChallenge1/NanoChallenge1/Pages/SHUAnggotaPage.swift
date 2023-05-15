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
    @State var totalSimpanan:Double = 0
    @State var totalPembelian:Double = 0
    @State var totalSHU:Double = 0
    @State var count:Int = 0
    

    var body: some View {
        @State var koperasiData:KoperasiModel = koperasiSharedData.koperasiDataSaved
        @State var a:[AnggotaModel] = koperasiSharedData.tambahAnggotaDataSaved
         
        GeometryReader{reader in
            NavigationStack{
                ScrollView{
                    VStack{
                        ForEach($koperasiSharedData.tambahAnggotaDataSaved, id: \.id) { $anggotaItem in
                            @State var totalSHU:Double = ((anggotaItem.simpanan / totalSimpanan) * (koperasiData.jasaModal/100) * koperasiData.SHUData ) + (((anggotaItem.pembelian / totalPembelian) * (koperasiData.jasaAnggota/100) * koperasiData.SHUData ))

                            SHUAnggotaItem(koperasiItem: $koperasiData, anggotaItem: $anggotaItem, totalSimpanan: $totalSimpanan, totalPinjaman: $totalPembelian, totalSHU: $totalSHU)
                        }.padding([.leading, .trailing], 20)
                    }                    .navigationTitle("SHU Anggota")
                    
                }.searchable(text: $searchText)
            }.onAppear(){
                if count == koperasiSharedData.tambahAnggotaDataSaved.count{
                    print("cukup di \(count)")
                }
                else{
                    for i in 0..<koperasiSharedData.tambahAnggotaDataSaved.count {
                        count += 1
                        let data:AnggotaModel = koperasiSharedData.tambahAnggotaDataSaved[i]
                        totalSimpanan += data.simpanan
                        totalPembelian += data.pembelian

                    }
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
