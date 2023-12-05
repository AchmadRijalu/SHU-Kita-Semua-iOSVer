//
//  SHUAnggotaItem.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 07/05/23.
//

import SwiftUI

struct SHUAnggotaItem: View {
    
    
    @Binding var anggotaItem:AnggotaModel
    @State var totalSHU:Double = 0
    @EnvironmentObject var koperasiSharedData:KoperasiSharedData
    let formatter = NumberFormatter()
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp "
        
        
        return formatter
    }()
    
    var body: some View {
        
        VStack{
            HStack{
                
                VStack(alignment: .leading){
                    Text("\(anggotaItem.name)").font(.title3).fontWeight(.bold).padding(.bottom, 1)
                    HStack{
                        Text("Sisa Hasil Usaha :").font(.subheadline).fontWeight(.medium)
                        Text("\(Self.currencyFormatter.string(from: NSNumber(value: totalSHU)) ?? "")").font(.subheadline).fontWeight(.medium)
                    }
                    
                }.padding(.leading, 8)
                Spacer()
                
            }
        }.padding(EdgeInsets(top: 12, leading: 23, bottom: 12, trailing: 23)).frame(maxWidth: .infinity, maxHeight: 96).background(Color("GrayColor")).cornerRadius(12).foregroundColor(.black).padding(.bottom, 12).onAppear(){

            totalSHU =  ((anggotaItem.simpanan / koperasiSharedData.totalSimpanan) * (koperasiSharedData.koperasiDataSaved.jasaModal/100) * koperasiSharedData.koperasiDataSaved.SHUData ) + (((anggotaItem.pembelian / koperasiSharedData.totalPembelian) * (koperasiSharedData.koperasiDataSaved.jasaAnggota/100) * koperasiSharedData.koperasiDataSaved.SHUData ))
            
            formatter.locale = Locale(identifier: "id_ID")
            formatter.groupingSeparator = "."
            formatter.numberStyle = .decimal
            if let formattedTipAmount = formatter.string(from: totalSHU as NSNumber) {
//                print("Harga : Rp " + formattedTipAmount + ",00")
            }
        }
    }
}

struct SHUAnggotaItem_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let shuModelPreview = SHUModel(name: "", SHU: 0)
        let anggotaModelPreview = AnggotaModel(name: "", pembelian: 0, simpanan: 0)
        let koperasiModelPreview = KoperasiModel(SHUData: 0, jasaModal: 0, jasaAnggota: 0)
        SHUAnggotaItem(anggotaItem: .constant(anggotaModelPreview), totalSHU: 0)
    }
}
