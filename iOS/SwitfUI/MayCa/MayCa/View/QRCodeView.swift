//
//  QRCodeView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/11.
//

import SwiftUI

struct QRCodeView: View {
    @Binding var isPresent: Bool
    @Binding var person: UserModel
    @State var qrImage:UIImage?
    @State var scanedString:String = ""
    @State var correctionLevel = 0
    @State private var showShareSheet = false
    @Environment(\.presentationMode) var presentationMode

    var _QRCodeMaker = QRCodeMaker()
    var body: some View {
        NavigationView{
            //Spacer()
            //Text("マイデータQRコード")
            //      .font(.system(size: 22))
            //      .foregroundColor(.blue)
            //Divider()
            VStack(spacing: 12) {
                //Text("マイデータQRコード")
                //    .font(.system(size: 22))
                //    .foregroundColor(.blue)
                //Divider()
                if qrImage != nil {
                    Image(uiImage: qrImage!)
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                
                HStack{
                    Spacer()
                    Button(action: {
                        //self.uiImage = UIApplication.shared.windows[0].rootViewController?.view!.getImage(rect: self.rect)
                        self.showShareSheet.toggle()
                    }) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                            Text("QRコード共有")
                        }
                    }.sheet(isPresented: self.$showShareSheet) {
                        ShareSheet(photo: self.qrImage!)
                    }.padding()
                    Spacer()
                    Button(action: {
                        withAnimation {
                            isPresent = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle")
                        Text("閉じる")
                    })
                    Spacer()
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .navigationBarTitle("QRコード表示",displayMode: .inline)
            /*
            .navigationBarItems(
                leading:
                    Button(action: {
                        //self.uiImage = UIApplication.shared.windows[0].rootViewController?.view!.getImage(rect: self.rect)
                        self.showShareSheet.toggle()
                    }) {
                        HStack{
                            Image(systemName: "square.and.arrow.up")
                            Text("マイデータの共有")
                        }
                    }.sheet(isPresented: self.$showShareSheet) {
                        ShareSheet(photo: self.qrImage!)
                    }.padding()
                ,trailing:
                    Button(action: {
                        withAnimation {
                            isPresent = false
                        }
                    }, label: {
                        Image(systemName: "xmark.circle")
                        Text("閉じる")
                    })
            )*/

            .onAppear(perform: {
                //self.viewModel.isFound = false
                //let person: UserModel = DB_Manager().getUser(idValue: g_index)
                UserDefaults.standard.set(true, forKey: "fullname")
                UserDefaults.standard.set(true, forKey: "company1")
                //UserDefaults.standard.set(true, forKey: "tel")
                //UserDefaults.standard.set(true, forKey: "email")
                

                //if (UserDefaults.standard.bool(forKey: "category")) {
                //    self.scanedString += "'category'=" + person.category
                //}
                if (UserDefaults.standard.bool(forKey: "fullname")) {
                    self.scanedString += ",'fullname'=" + person.fullname
                }
                if (UserDefaults.standard.bool(forKey: "fullyomi")) {
                    self.scanedString += ",'fullyomi'=" + person.fullyomi
                }
                if (UserDefaults.standard.bool(forKey: "company1")) {
                    self.scanedString += ",'company1'=" + person.company1
                }
                if (UserDefaults.standard.bool(forKey: "company1yomi")) {
                    self.scanedString += ",'company1yomi'=" + person.company1yomi
                }
                if (UserDefaults.standard.bool(forKey: "company2")) {
                    self.scanedString += ",'company2'=" + person.company2
                }
                if (UserDefaults.standard.bool(forKey: "department")) {
                    self.scanedString += ",'department'=" + person.department
                }
                if (UserDefaults.standard.bool(forKey: "section")) {
                    self.scanedString += ",'section'=" + person.section
                }
                if (UserDefaults.standard.bool(forKey: "role")) {
                    self.scanedString += ",'role'=" + person.role
                }
                if (UserDefaults.standard.bool(forKey: "zipcode")) {
                    self.scanedString += ",'zipcode'=" + person.zipcode
                }
                if (UserDefaults.standard.bool(forKey: "address1")) {
                    self.scanedString += ",'address1'=" + person.address1
                }
                if (UserDefaults.standard.bool(forKey: "address2")) {
                    self.scanedString += ",'address2'=" + person.address2
                }
                if (UserDefaults.standard.bool(forKey: "tel")) {
                    self.scanedString += ",'tel'=" + person.tel
                }
                if (UserDefaults.standard.bool(forKey: "fax")) {
                    self.scanedString += ",'fax'=" + person.fax
                }
                if (UserDefaults.standard.bool(forKey: "email")) {
                    self.scanedString += ",'email'=" + person.email
                }
                if (UserDefaults.standard.bool(forKey: "homepage")) {
                    self.scanedString += ",'homepage'=" + person.homepage
                }
                if (UserDefaults.standard.bool(forKey: "facebook")) {
                    self.scanedString += ",'facebook'=" + person.facebook
                }
                if (UserDefaults.standard.bool(forKey: "twitter")) {
                    self.scanedString += ",'twitter'=" + person.twitter
                }
                if (UserDefaults.standard.bool(forKey: "instagram")) {
                    self.scanedString += ",'instagram'=" + person.instagram
                }
                if (UserDefaults.standard.bool(forKey: "line_id")) {
                    self.scanedString += ",'line_id'=" + person.line_id
                }
                if (UserDefaults.standard.bool(forKey: "youtube")) {
                    self.scanedString += ",'youtube'=" + person.youtube
                }
                if (UserDefaults.standard.bool(forKey: "sns")) {
                    self.scanedString += ",'sns'=" + person.sns
                }
                /*
                if (UserDefaults.standard.bool(forKey: "meeting_date  ")) {
                    //処理
                }
                if (UserDefaults.standard.bool(forKey: "meeting_place")) {
                    //処理
                }
                if (UserDefaults.standard.bool(forKey: "latitude")) {
                    //処理
                }
                if (UserDefaults.standard.bool(forKey: "longitude")) {
                    //処理
                }*/
                if (UserDefaults.standard.bool(forKey: "birth_date  ")) {
                    self.scanedString += ",'birth_date_str'=" + person.birth_date_str
                }
                if (UserDefaults.standard.bool(forKey: "familyname")) {
                    self.scanedString += ",'familyname'=" + person.familyname
                }
                if (UserDefaults.standard.bool(forKey: "givenname")) {
                    self.scanedString += ",'givenname'=" + person.givenname
                }
                if (UserDefaults.standard.bool(forKey: "middlename")) {
                    self.scanedString += ",'middlename'=" + person.middlename
                }
                if (UserDefaults.standard.bool(forKey: "handlename")) {
                    self.scanedString += ",'handlename'=" + person.handlename
                }
                if (UserDefaults.standard.bool(forKey: "temp1")) {
                    self.scanedString += ",'temp1'=" + person.temp1
                }
                if (UserDefaults.standard.bool(forKey: "temp2")) {
                    self.scanedString += ",'temp2'=" + person.temp2
                }
                if (UserDefaults.standard.bool(forKey: "temp3")) {
                    self.scanedString += ",'temp3'=" + person.temp3
                }
                if (UserDefaults.standard.bool(forKey: "temp4")) {
                    self.scanedString += ",'temp4'=" + person.temp4
                }
                if (UserDefaults.standard.bool(forKey: "temp5")) {
                    self.scanedString += ",'temp5'=" + person.temp5
                }
                if (UserDefaults.standard.bool(forKey: "temp6")) {
                    self.scanedString += ",'temp6'=" + person.temp6
                }
                if (UserDefaults.standard.bool(forKey: "temp7")) {
                    self.scanedString += ",'temp7'=" + person.temp7
                }
                if (UserDefaults.standard.bool(forKey: "logoImageName")) {
                    self.scanedString += ",'logoImageName'=" + person.logoImageName
                }
                if (UserDefaults.standard.bool(forKey: "profileImageName")) {
                    self.scanedString += ",'profileImageName'=" + person.profileImageName
                }
                self.qrImage = self._QRCodeMaker.make(message: self.scanedString, level: self.correctionLevel)
                print("qrcode : \(self.scanedString)")
            })
        }
    }
}

/*
struct QRCodeView_Previews: PreviewProvider {
    var istest = false
    static var previews: some View {
        QRCodeView(isPresent: istest)
    }
}
*/
