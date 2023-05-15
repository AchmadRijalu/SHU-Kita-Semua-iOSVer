//
//  SHUAnggotaItem.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 07/05/23.
//

import SwiftUI

struct SHUAnggotaItem: View {
    
    //    @Binding var SHUItem:SHUModel
    
    @Binding var koperasiItem:KoperasiModel
    
    @Binding var anggotaItem:AnggotaModel
    
    
    @Binding var totalSimpanan:Double
    @Binding var totalPinjaman:Double
    
    @Binding var totalSHU:Double
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
    
                    let formattedPrice = formatter.string(from: NSNumber(value: totalSHU))
                    
                    HStack{
                        Text("Sisa Hasil Usaha :").fontWeight(.semibold)
                        Text("\(Self.currencyFormatter.string(from: NSNumber(value: totalSHU)) ?? "")").fontWeight(.medium)
                    }
                    
                }.padding(.leading, 8)
                
                Spacer()
            }
        }.padding(EdgeInsets(top: 12, leading: 23, bottom: 12, trailing: 23)).frame(maxWidth: .infinity, maxHeight: 96).background(Color("GrayColor")).cornerRadius(12).foregroundColor(.black).padding(.bottom, 12).onAppear(){
        
            formatter.locale = Locale(identifier: "id_ID")
            formatter.groupingSeparator = "."
            formatter.numberStyle = .decimal
            if let formattedTipAmount = formatter.string(from: totalSHU as NSNumber) {
               print("Harga : Rp " + formattedTipAmount + ",00")
            }
        }
    }
}

struct SHUAnggotaItem_Previews: PreviewProvider {
    
    
    static var previews: some View {
        let shuModelPreview = SHUModel(name: "", SHU: 0)
        let anggotaModelPreview = AnggotaModel(name: "", pembelian: 0, simpanan: 0)
        let koperasiModelPreview = KoperasiModel(SHUData: 0, jasaModal: 0, jasaAnggota: 0)
        SHUAnggotaItem(koperasiItem: .constant(koperasiModelPreview), anggotaItem: .constant(anggotaModelPreview), totalSimpanan: .constant(0), totalPinjaman: .constant(0), totalSHU: .constant(0))
    }
}
