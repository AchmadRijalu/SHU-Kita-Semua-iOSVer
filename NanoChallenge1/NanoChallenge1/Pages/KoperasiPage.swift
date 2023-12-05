//
//  KoperasiPage.swift
//  NanoChallenge1
//
//  Created by Achmad Rijalu on 05/05/23.
//

import SwiftUI

struct KoperasiPage: View {
    
    @State private var editDataKoperasishowSheet:Bool = false
    @State private var tambahAnggotaShowSheet:Bool = false
    @State var koperasiData = KoperasiModel(SHUData: 250000, jasaModal: 20, jasaAnggota: 25)
    private var tambahAnggota:AnggotaModel?
    @EnvironmentObject var koperasiSharedData:KoperasiSharedData
    @State var anggotaListObs:[AnggotaModel]?
    
    
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "Rp "
        return formatter
    }()

    var body: some View {
        
        GeometryReader{reader in
            NavigationStack{
                ScrollView{
                    VStack{
                        HStack{
                            Text("Data Koperasi").font(.title3).fontWeight(.bold)
                            Spacer()
                        }.padding(.top, 21)
                        
                        VStack{
                            HStack{
                                Text("Total SHU Koperasi").fontWeight(.medium)
                                Spacer()
                                Button(action: { self.editDataKoperasishowSheet.toggle()}) {
                                    Text("Ubah").fontWeight(.bold)
                                }.sheet(isPresented: $editDataKoperasishowSheet,  content: {
                                    UbahKoperasiSheet(koperasiData: $koperasiSharedData.koperasiDataSaved, updateKoperasiSaveData: $koperasiSharedData.koperasiDataSaved)
                                })
                                .padding(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
                                .foregroundColor(.white)
                                .background(Color("PrimaryColor")).cornerRadius(30)
                            }
                            HStack{
                                //VALUE OF SHU Koperasi
                                Text("\(Self.currencyFormatter.string(from: NSNumber(value:                                 koperasiSharedData.koperasiDataSaved.SHUData)) ?? "")").font(.title2).fontWeight(.bold)
                                Spacer()
                                
                                
                            }
                            
                            HStack{
                                //Jasa Modal
                                VStack{
                                    Text("Jasa Modal").fontWeight(.medium)
                                    
                                    Text("\(String(format: "%.0f",koperasiSharedData.koperasiDataSaved.jasaModal )) %").font(.title3).fontWeight(.semibold).padding(.top, 16)
                                }
                                Spacer()
                                Divider()
                                    .frame(height: 80).overlay(.gray)
                                Spacer()
                                //Jasa Anggota
                                VStack{
                                    Text("Jasa Anggota").fontWeight(.medium)
                                    
                                    Text("\(String(format: "%.0f", koperasiSharedData.koperasiDataSaved.jasaAnggota )) %").font(.title3).fontWeight(.semibold).padding(.top, 16)
                                }
                            }
                            
                        }.padding(EdgeInsets(top: 27, leading: 23, bottom: 27, trailing: 23)).frame(maxWidth: .infinity, maxHeight:200).background(Color("GrayColor")).cornerRadius(30).onAppear(){
                            
                        }
                        
                        HStack{
                            Text("Daftar Anggota").font(.title3).fontWeight(.bold)
                            Spacer()
                            Button(action:{self.tambahAnggotaShowSheet.toggle()} , label:{
                                Image(systemName: "plus")
                                
                            }).sheet(isPresented: $tambahAnggotaShowSheet,onDismiss: {
                                
                                // perform your action here
   
                            },  content: {
                                
                                TambahAnggotaSheet(tambahAnggotaSaveData: $koperasiSharedData.tambahAnggotaDataSaved)
                                
                            }).padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                                .foregroundColor(.white)
                                .background(Color("PrimaryColor")).cornerRadius(30)
                        }.padding(.top, 21).padding(.bottom, 12)
                        
                        ForEach($koperasiSharedData.tambahAnggotaDataSaved, id: \.id) { $anggotaItem in
                            DaftarAnggotaItem(daftarAnggotaItem: $anggotaItem, tambahAnggotaDataSaved: $koperasiSharedData.tambahAnggotaDataSaved)
                        }
                        
                    }.padding([.leading, .trailing], 20).onAppear(){

                    }
                    
                }
                
                .navigationTitle("Koperasi")
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(.white)
        
    }
}

struct UbahKoperasiSheet: View {
    
    @Binding var koperasiData:KoperasiModel
    @Binding var updateKoperasiSaveData:KoperasiModel
    @EnvironmentObject var koperasiSharedData:KoperasiSharedData
    
    @Environment(\.presentationMode) var presentationMode
    
    @FocusState var isFocused:Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                Form{
                    VStack(alignment: .leading){
                        Text("Total SHU Koperasi").font(.subheadline)
                        
                        TextField( "Masukkan Total SHU", value: $koperasiData.SHUData, formatter: NumberFormatter()).keyboardType(.numberPad).focused($isFocused).toolbar{
                            ToolbarItemGroup(placement: .keyboard){
                                Spacer()
                                Button("Done"){
                                    isFocused = false
                                }
                            }
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Text("Jasa Modal").font(.subheadline)
                        HStack{
                            TextField( "Masukkan Jasa Modal", value: $koperasiData.jasaModal, formatter: NumberFormatter()).keyboardType(.numberPad).focused($isFocused).toolbar{
                                ToolbarItemGroup(placement: .keyboard){
                                    
                                }
                            }
                            Text("%").foregroundColor(.black).fontWeight(.semibold)
                        }
                        
                    }.padding(.top, 8)
                    
                    VStack(alignment: .leading){
                        Text("Jasa Anggota").font(.subheadline)
                        HStack{
                            TextField( "Masukkan Jasa Anggota", value: $koperasiData.jasaAnggota, formatter: NumberFormatter()).keyboardType(.numberPad).focused($isFocused).toolbar{
                                ToolbarItemGroup(placement: .keyboard){
                                }
                            }
                            Text("%").foregroundColor(.black).fontWeight(.semibold)
                        }
                        
                    }.padding(.top, 8)
                    
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.black)
                .background(Color.white)
            
                .navigationTitle("Ubah Data Koperasi")
                .navigationBarItems(leading: Button("Kembali",
                                                    action: {
                    presentationMode.wrappedValue.dismiss()
                }).foregroundColor(Color("PrimaryColor")))
                .navigationBarItems(trailing: Button("Ubah",
                                                     action: {
                    
                    //save to local user default
                    UserDefaults.standard.storeCodable(updateKoperasiSaveData, key: "koperasiUserDefaultKey")
                    
                    koperasiSharedData.count = false
                    print("edit jadi : \(koperasiSharedData.count)")
                    
                    presentationMode.wrappedValue.dismiss()
                }).foregroundColor(Color("PrimaryColor")) )
        }
        
    }
}
struct TambahAnggotaSheet: View {
    
    @Environment(\.dismiss) var dismiss
    //    @StateObject var anggotaListTambah = AnggotaList()
    @EnvironmentObject var anggotaListTambah:KoperasiSharedData
    @Binding var tambahAnggotaSaveData:[AnggotaModel]
    @State private var name = ""
    @State private var pembelian = ""
    @State private var simpanan = ""
    
    @FocusState var isFocused:Bool
    var body: some View {
        
        NavigationStack{
            VStack{
                Form{
                    VStack(alignment: .leading){
                        Text("Nama Anggota").font(.subheadline)
                        
                        TextField( "Masukkan Nama", text: $name)
                    }
                    VStack(alignment: .leading){
                        Text("Pembelian").font(.subheadline)
                        HStack{
                            TextField("Masukkan Pembelian", text: $pembelian).keyboardType(.numberPad)
                            
                        }.padding(.top, 8)
                        VStack(alignment: .leading){
                            Text("Simpanan").font(.subheadline)
                            HStack{
                                TextField( "Masukkan Simpanan", text: $simpanan).keyboardType(.numberPad)
                            }
                        }.padding(.top, 8)
                        
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity).foregroundColor(.black)
                    .background(Color.white)
                
                    .navigationTitle("Tambah Anggota")
                    .navigationBarItems(leading: Button("Kembali",
                                                        action: {
                        dismiss()
                    }).foregroundColor(Color("PrimaryColor")))
                    .navigationBarItems(trailing: Button("Tambah",
                                                         action: {
                        let createNewAnggota = AnggotaModel(name: name, pembelian: Double(pembelian) ?? 0, simpanan: Double(simpanan) ?? 0)
                        
                        tambahAnggotaSaveData.append(createNewAnggota)
                        //                        anggotaListTambah.anggotaList.append(createNewAnggota)
                        
                        UserDefaults.standard.storeCodable(tambahAnggotaSaveData, key: "anggotaUserDefaultKey")
                        
                        anggotaListTambah.count = false
                        print("edit jadi : \(anggotaListTambah.count)")
                        

                        dismiss()
                        
                    }).disabled(name.isEmpty || pembelian.isEmpty || simpanan.isEmpty).foregroundColor(
                        name.isEmpty || pembelian.isEmpty || simpanan.isEmpty ?
                            .gray: Color("PrimaryColor")))
            }
            .navigationTitle("Edit Koperasi").navigationBarTitleDisplayMode(.inline)
            
            
        }
        
    }
    
    struct KoperasiPage_Previews: PreviewProvider {
        static let myEnvObject = KoperasiSharedData()
        static var previews: some View {
            KoperasiPage( ).environmentObject(myEnvObject)
        }
    }
}
