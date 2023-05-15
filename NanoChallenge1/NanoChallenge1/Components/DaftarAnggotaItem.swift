//
//  DaftarAnggotaItem.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 05/05/23.
//

import SwiftUI



struct DaftarAnggotaItem: View {
    
    @State private var editDataAnggotaShowSheet:Bool = false
    
    @Binding var daftarAnggotaItem:AnggotaModel
    @Binding var tambahAnggotaDataSaved : [AnggotaModel]
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
                    Text(daftarAnggotaItem.name).font(.title3).fontWeight(.bold).padding(.bottom, 1)
                    HStack{
                        Text("Pembelian :").fontWeight(.medium)
                        Text("\(Self.currencyFormatter.string(from: NSNumber(value:                                 daftarAnggotaItem.pembelian)) ?? "")")
                    }
                    HStack{
                        Text("Simpanan :").fontWeight(.medium)
                        Text("\(Self.currencyFormatter.string(from: NSNumber(value:                                 daftarAnggotaItem.simpanan)) ?? "")")
                    }
                }.padding(.leading, 8)
                Spacer()
                Button(action: {self.editDataAnggotaShowSheet.toggle()}) {
                    Text("Ubah").fontWeight(.bold)
                }.sheet(isPresented: $editDataAnggotaShowSheet,  content: {
                    UbahAnggotaSheet(ubahAnggotaData: $daftarAnggotaItem, tambahAnggotaDataSaved: $tambahAnggotaDataSaved)
                })
                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                .foregroundColor(.white)
                .background(Color("PrimaryColor")).cornerRadius(30)
            }
        }.padding(EdgeInsets(top: 12, leading: 23, bottom: 12, trailing: 23)).frame(maxWidth: .infinity, maxHeight: 96).background(Color("GrayColor")).cornerRadius(12).padding(.bottom, 12).shadow(color: Color("PrimaryColor"), radius: 2, x: 1, y: 3)
    }
}




struct UbahAnggotaSheet: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var ubahAnggotaData:AnggotaModel //a
    @Binding var tambahAnggotaDataSaved: [AnggotaModel]
    @State private var formattedValue: String = ""
    var body: some View {
        
        NavigationStack{
            VStack{
                Form{
                    VStack(alignment: .leading){
                        Text("Nama Anggota").font(.subheadline)
                        
                        TextField( "Masukkan Nama", text: $ubahAnggotaData.name).submitLabel(.done)
                    }
                    VStack(alignment: .leading){
                        Text("Pembelian").font(.subheadline)
                        HStack{
                            TextField("Ubah Pembelian", value: $ubahAnggotaData.pembelian, formatter: NumberFormatter())
                            
                        }.padding(.top, 8)
                        VStack(alignment: .leading){
                            Text("Simpanan").font(.subheadline)
                            HStack{
                                TextField( "Ubah Simpanan", value: $ubahAnggotaData.simpanan, formatter: NumberFormatter() ).keyboardType(.numberPad).submitLabel(.done)
                            }
                        }.padding(.top, 8)
                        
                    }
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.black)
                .background(Color.white)
                .navigationTitle("Ubah Data Anggota")
                .navigationBarItems(leading: Button("Kembali",
                                                    action: {
                    presentationMode.wrappedValue.dismiss()
                }).foregroundColor(Color("PrimaryColor")))
            
                .navigationBarItems(trailing: Button("Ubah",
                                                     action: {
                    
                    if let index = tambahAnggotaDataSaved.firstIndex(where: {$0.id == ubahAnggotaData.id}) {
                        tambahAnggotaDataSaved[index] = ubahAnggotaData
                        
                    }
                    //save to local user default
                    UserDefaults.standard.storeCodable(tambahAnggotaDataSaved, key: "anggotaUserDefaultKey")
                    presentationMode.wrappedValue.dismiss()
                }).foregroundColor(Color("PrimaryColor")) )
        }
        
        .navigationTitle("Edit Koperasi").navigationBarTitleDisplayMode(.inline)
    }
}

struct DaftarAnggotaItem_Previews: PreviewProvider {
    static let anggotaModelPreview = AnggotaModel(name: "", pembelian: 0, simpanan: 0)
    static let listAnggotaModel : [AnggotaModel] = []
    static var previews: some View {
        //        DaftarAnggotaItem(name: "Achmad Rijalu", pembelian: 25000, simpanan: 20000)
        DaftarAnggotaItem(daftarAnggotaItem: .constant(anggotaModelPreview), tambahAnggotaDataSaved:.constant(listAnggotaModel))
    }
}
