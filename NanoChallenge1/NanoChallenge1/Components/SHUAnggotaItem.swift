//
//  SHUAnggotaItem.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 07/05/23.
//

import SwiftUI

struct SHUAnggotaItem: View {
    var body: some View {
        VStack{
            HStack{
                VStack{
                    Image(systemName: "banknote.fill")
                }.padding(.all,9).frame(width: 36, height: 36).background(.white).cornerRadius(50).foregroundColor(.black)
                
                VStack(alignment: .leading){
                    Text("Achmad Rijalu").fontWeight(.bold).padding(.bottom, 1)
                    
                    HStack{
                        Text("Sisa Hasil Usaha :").fontWeight(.bold)
                        Text("Rp. 200.000").fontWeight(.medium)
                    }
                }.padding(.leading, 8)
                
                
            }
        }.padding(EdgeInsets(top: 12, leading: 23, bottom: 12, trailing: 23)).frame(maxWidth: .infinity, maxHeight: 96).background(Color("PrimaryColor")).cornerRadius(12).foregroundColor(.white).padding(.bottom, 12)
    }
}

struct SHUAnggotaItem_Previews: PreviewProvider {
    static var previews: some View {
        SHUAnggotaItem()
    }
}
