//
//  EditUserView.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import SwiftUI
 
struct EditUserView: View {
     
    // id receiving of user from previous view
    @Binding var id: Int64
     
    // variables to store value from input fields
    @State var name: String = ""
    @State var age: String = ""
    @State var category: String = ""
    @State var fullname: String = ""
    @State var fullyomi: String = ""
    @State var company1: String = ""
    @State var company1yomi: String = ""
    @State var company2: String = ""
    @State var department: String = ""
    @State var section: String = ""
    @State var role: String = ""
    @State var zipcode: String = ""
    @State var address1: String = ""
    @State var address2: String = ""
    @State var tel: String = ""
    @State var fax: String = ""
    @State var email: String = ""
    @State var homepage: String = ""
    @State var facebook: String = ""
    @State var twitter: String = ""
    @State var instagram: String = ""
    @State var line_id: String = ""
    @State var youtube: String = ""
    @State var sns: String = ""
    @State var meeting_date_str: String = ""
    @State var meeting_place: String = ""
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var birth_date_str: String = ""
    @State var familyname: String = ""
    @State var givenname: String = ""
    @State var middlename: String = ""
    @State var handlename: String = ""
    @State var temp1: String = ""
    @State var temp2: String = ""
    @State var temp3: String = ""
    @State var temp4: String = ""
    @State var temp5: String = ""
    @State var temp6: String = ""
    @State var temp7: String = ""
    @State var logoImageName: String = ""
    @State var profileImageName: String = ""
     
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        ScrollView{
            VStack {
                // create name field
                TextField("Enter name", text: $name)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .disableAutocorrection(true)
                 
                // create age field, number pad
                TextField("Enter age", text: $age)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(5)
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                        Group{

                          HStack {
                               Text("カテゴリ:")
                                   .font(.callout)
                                   .bold()
                              TextField("カテゴリ", text: $category).environment(\.isEnabled, true)
                                   .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("氏名:")
                                   .font(.callout)
                                   .bold()
                            TextField("氏名", text: $fullname)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("フリガナ:")
                                   .font(.callout)
                                   .bold()
                            TextField("フリガナ", text: $fullyomi)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("会社名1:")
                                   .font(.callout)
                                   .bold()
                            TextField("会社名1", text: $company1)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("フリガナ:")
                                   .font(.callout)
                                   .bold()
                            TextField("フリガナ", text: $company1yomi)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("会社名2:")
                                   .font(.callout)
                                   .bold()
                            TextField("会社名2", text: $company2)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("所属部署（部）:")
                                   .font(.callout)
                                   .bold()
                            TextField("所属部署（部）", text: $department)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("所属部署（課）:")
                                   .font(.callout)
                                   .bold()
                            TextField("所属部署（課）", text: $section)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("役職:")
                                   .font(.callout)
                                   .bold()
                            TextField("役職", text: $role)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                       }//Group
                       Group{
                          HStack {
                               Text("郵便番号:")
                                   .font(.callout)
                                   .bold()
                            TextField("郵便番号", text: $zipcode)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("住所1:")
                                   .font(.callout)
                                   .bold()
                            TextField("住所1", text: $address1)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("住所2:")
                                   .font(.callout)
                                   .bold()
                            TextField("住所2", text: $address2)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("TEL:")
                                   .font(.callout)
                                   .bold()
                            TextField("TEL", text: $tel)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("FAX:")
                                   .font(.callout)
                                   .bold()
                            TextField("FAX", text: $fax)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                          HStack {
                               Text("E-mail:")
                                   .font(.callout)
                                   .bold()
                            TextField("E-mail", text: $email)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           .padding()
                       }//Group
                       Group{
                          HStack {
                               Text("URL:")
                                   .font(.callout)
                                   .bold()
                            TextField("URL", text: $homepage)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("facebook:")
                                   .font(.callout)
                                   .bold()
                            TextField("facebook", text: $facebook)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("instagram:")
                                   .font(.callout)
                                   .bold()
                            TextField("instagram", text: $instagram)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("twitter:")
                                   .font(.callout)
                                   .bold()
                            TextField("twitter", text: $twitter)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("LINE ID:")
                                   .font(.callout)
                                   .bold()
                            TextField("LINE ID", text: $line_id)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("YouTube:")
                                   .font(.callout)
                                   .bold()
                            TextField("YouTube", text: $youtube)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("SNS:")
                                   .font(.callout)
                                   .bold()
                            TextField("SNS", text: $sns)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                       }//Group
                       Group{
                            MapView(latitude: latitude,longitude: longitude)
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 200)

                          HStack {
                               Text("名刺交換日:")
                                   .font(.callout)
                                   .bold()
                            TextField("名刺交換日", text: $meeting_date_str)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("名刺交換場所:")
                                   .font(.callout)
                                   .bold()
                            TextField("名刺交換場所", text: $meeting_place)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("名刺交換緯度:")
                                   .font(.callout)
                                   .bold()
                            TextField("名刺交換緯度", text: $latitude)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
        
                           }
                           //.padding()
                          HStack {
                               Text("名刺交換経度:")
                                   .font(.callout)
                                   .bold()
                            TextField("名刺交換経度", text: $longitude)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
        
                           }
                           //.padding()
                       }//Group
                       Group{
                          HStack {
                               Text("姓:")
                                   .font(.callout)
                                   .bold()
                            TextField("姓", text: $familyname)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("名:")
                                   .font(.callout)
                                   .bold()
                            TextField("名", text: $givenname)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("ミドルネーム:")
                                   .font(.callout)
                                   .bold()
                            TextField("ミドルネーム", text: $middlename)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("ハンドルネーム:")
                                   .font(.callout)
                                   .bold()
                            TextField("ハンドルネーム", text: $handlename)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("誕生日:")
                                   .font(.callout)
                                   .bold()
                            TextField("誕生日", text: $birth_date_str)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("任意1:")
                                   .font(.callout)
                                   .bold()
                            TextField("任意1", text: $temp1)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("任意2:")
                                   .font(.callout)
                                   .bold()
                            TextField("任意2", text: $temp2)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()
                          HStack {
                               Text("任意3:")
                                   .font(.callout)
                                   .bold()
                            TextField("任意3", text: $temp3)
                                  .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                           }
                           //.padding()

                       }//Group
                 
                // button to update user
                Button(action: {
                    // call function to update row in sqlite database
                    DB_Manager().updateUser(idValue: self.id, categoryValue:self.category, fullnameValue:self.fullname, fullyomiValue:self.fullyomi, company1Value:self.company1, company1yomiValue:self.company1yomi, company2Value:self.company2, departmentValue:self.department, sectionValue:self.section, roleValue:self.role, zipcodeValue:self.zipcode, address1Value:self.address1, address2Value:self.address2, telValue:self.tel, faxValue:self.fax, emailValue: self.email, homepageValue:self.homepage, facebookValue:self.facebook, twitterValue:self.twitter, instagramValue:self.instagram, line_idValue:self.line_id, youtubeValue:self.youtube, snsValue:self.sns, meeting_date_strValue:self.meeting_date_str, meeting_placeValue:self.meeting_place, latitudeValue:self.latitude, longitudeValue:self.longitude, birth_date_strValue:self.birth_date_str, familynameValue:self.familyname, givennameValue:self.givenname, middlenameValue:self.middlename, handlenameValue:self.handlename, temp1Value:self.temp1, temp2Value:self.temp2, temp3Value:self.temp3, temp4Value:self.temp4, temp5Value:self.temp5, temp6Value:self.temp6, temp7Value:self.temp7, logoImageNameValue:self.logoImageName, profileImageNameValue:self.profileImageName)
 
                    // go back to home page
                    self.mode.wrappedValue.dismiss()
                }, label: {
                    Text("Edit User")
                })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }.padding()
        }//ScrollView
 
        // populate user's data in fields when view loaded
        .onAppear(perform: {
             
            // get data from database
            let userModel: UserModel = DB_Manager().getUser(idValue: self.id)
             
            // populate in text fields
            self.category = userModel.category
            self.fullname = userModel.fullname
            self.fullyomi = userModel.fullyomi
            self.company1 = userModel.company1
            self.company1yomi = userModel.company1yomi
            self.company2 = userModel.company2
            self.department = userModel.department
            self.section = userModel.section
            self.role = userModel.role
            self.zipcode = userModel.zipcode
            self.address1 = userModel.address1
            self.address2 = userModel.address2
            self.tel = userModel.tel
            self.fax = userModel.fax
            self.email = userModel.email
            self.homepage = userModel.homepage
            self.facebook = userModel.facebook
            self.twitter = userModel.twitter
            self.instagram = userModel.instagram
            self.line_id = userModel.line_id
            self.youtube = userModel.youtube
            self.sns = userModel.sns
            self.meeting_date_str = userModel.meeting_date_str
            self.meeting_place = userModel.meeting_place
            self.latitude = userModel.latitude
            self.longitude = userModel.longitude
            self.birth_date_str = userModel.birth_date_str
            self.familyname = userModel.familyname
            self.givenname = userModel.givenname
            self.middlename = userModel.middlename
            self.handlename = userModel.handlename
            self.temp1 = userModel.temp1
            self.temp2 = userModel.temp2
            self.temp3 = userModel.temp3
            self.temp4 = userModel.temp4
            self.temp5 = userModel.temp5
            self.temp6 = userModel.temp6
            self.temp7 = userModel.temp7
            self.logoImageName = userModel.logoImageName
            self.profileImageName = userModel.profileImageName
        })
    }
}
 
struct EditUserView_Previews: PreviewProvider {
     
    // when using @Binding, do this in preview provider
    @State static var id: Int64 = 0
     
    static var previews: some View {
        EditUserView(id: $id)
    }
}
