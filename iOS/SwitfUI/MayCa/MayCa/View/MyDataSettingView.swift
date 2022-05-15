//
//  MyDataSettingView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/05/01.
//

import SwiftUI

struct MyDataSettingView: View {
    @State var settingflag: UserSettingModel = UserSettingModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView{
            VStack{
                //Spacer()
                //Text("マイデータ転送設定")
                //      .font(.system(size: 22))
                //      .foregroundColor(.blue)
                //Divider()
                //ScrollView{
                //広告ビュー
                AdView().frame(width: 320, height: 50, alignment: .center)
                Form {
                   VStack(alignment: .center){
                      Group{
                         //Toggle("カテゴリ", isOn : $settingflag.category)

                         Toggle("氏名", isOn : $settingflag.fullname)

                         Toggle("フリガナ", isOn : $settingflag.fullyomi)

                         Toggle("会社名1", isOn : $settingflag.company1)

                         Toggle("フリガナ", isOn : $settingflag.company1yomi)

                         Toggle("会社名2", isOn : $settingflag.company2)

                         Toggle("所属部署（部）", isOn : $settingflag.department)

                         Toggle("所属部署（課）", isOn : $settingflag.section)

                         Toggle("役職", isOn : $settingflag.role)

                         Toggle("郵便番号", isOn : $settingflag.zipcode)

                      }
                      Group{
                         Toggle("住所1", isOn : $settingflag.address1)

                         Toggle("住所2", isOn : $settingflag.address2)

                         Toggle("TEL", isOn : $settingflag.tel)

                         Toggle("Mobile Phone", isOn : $settingflag.temp6)

                         Toggle("FAX", isOn : $settingflag.fax)

                         Toggle("E-mail", isOn : $settingflag.email)

                         Toggle("URL", isOn : $settingflag.homepage)

                         Toggle("会社ロゴ", isOn : $settingflag.logoImageName)

                         Toggle("顔写真", isOn : $settingflag.profileImageName)
                      }
                      Group{
                         Toggle("facebook", isOn : $settingflag.facebook)

                         Toggle("instagram", isOn : $settingflag.instagram)

                         Toggle("twitter", isOn : $settingflag.twitter)

                         Toggle("LINE ID", isOn : $settingflag.line_id)

                         Toggle("YouTube", isOn : $settingflag.youtube)

                         Toggle("SNS", isOn : $settingflag.sns)

                      }
                      /*
                      Group{
                         Toggle("名刺交換日", isOn : $settingflag.meeting_date)

                         Toggle("名刺交換場所", isOn : $settingflag.meeting_place)

                         Toggle("名刺交換緯度", isOn : $settingflag.latitude)

                         Toggle("名刺交換経度", isOn : $settingflag.longitude)

                      }*/
                      Group{
                         Toggle("姓", isOn : $settingflag.familyname)

                         Toggle("名", isOn : $settingflag.givenname)

                         Toggle("ミドルネーム", isOn : $settingflag.middlename)

                         Toggle("ハンドルネーム", isOn : $settingflag.handlename)

                         Toggle("誕生日", isOn : $settingflag.birth_date)

                         Toggle("性別", isOn : $settingflag.temp7)
                      }
                      Group{
                         Toggle("任意1", isOn : $settingflag.temp1)

                         Toggle("任意2", isOn : $settingflag.temp2)

                         Toggle("任意3", isOn : $settingflag.temp3)

                         Toggle("任意4", isOn : $settingflag.temp4)

                         Toggle("任意5", isOn : $settingflag.temp5)

                      }
                   }
               }
            }//VStack
            .onAppear(perform: {
                /*UserDefaults.register(defaults: [
                      "fullname" : true,
                      "company1" : true,
                      "tel" : true,
                      "email" : true])*/
                //必須項目
                UserDefaults.standard.set(true, forKey: "fullname")
                UserDefaults.standard.set(true, forKey: "company1")
                //UserDefaults.standard.set(true, forKey: "tel")
                //UserDefaults.standard.set(true, forKey: "email")
                
                //必須以外
                //settingflag.category = UserDefaults.standard.bool(forKey: "category")
                settingflag.fullname = UserDefaults.standard.bool(forKey: "fullname")
                settingflag.fullyomi = UserDefaults.standard.bool(forKey: "fullyomi")
                settingflag.company1 = UserDefaults.standard.bool(forKey: "company1")
                settingflag.company1yomi = UserDefaults.standard.bool(forKey: "company1yomi")
                settingflag.company2 = UserDefaults.standard.bool(forKey: "company2")
                settingflag.department = UserDefaults.standard.bool(forKey: "department")
                settingflag.section = UserDefaults.standard.bool(forKey: "section")
                settingflag.role = UserDefaults.standard.bool(forKey: "role")
                settingflag.zipcode = UserDefaults.standard.bool(forKey: "zipcode")
                settingflag.address1 = UserDefaults.standard.bool(forKey: "address1")
                settingflag.address2 = UserDefaults.standard.bool(forKey: "address2")
                settingflag.tel = UserDefaults.standard.bool(forKey: "tel")
                settingflag.fax = UserDefaults.standard.bool(forKey: "fax")
                settingflag.email = UserDefaults.standard.bool(forKey: "email")
                settingflag.homepage = UserDefaults.standard.bool(forKey: "homepage")
                settingflag.facebook = UserDefaults.standard.bool(forKey: "facebook")
                settingflag.twitter = UserDefaults.standard.bool(forKey: "twitter")
                settingflag.instagram = UserDefaults.standard.bool(forKey: "instagram")
                settingflag.line_id = UserDefaults.standard.bool(forKey: "line_id")
                settingflag.youtube = UserDefaults.standard.bool(forKey: "youtube")
                settingflag.sns = UserDefaults.standard.bool(forKey: "sns")
                /*
                settingflag.meeting_date   = UserDefaults.standard.bool(forKey: "meeting_date  ")
                settingflag.meeting_place = UserDefaults.standard.bool(forKey: "meeting_place")
                settingflag.latitude = UserDefaults.standard.bool(forKey: "latitude")
                settingflag.longitude = UserDefaults.standard.bool(forKey: "longitude")
                */
                settingflag.birth_date   = UserDefaults.standard.bool(forKey: "birth_date  ")
                settingflag.familyname = UserDefaults.standard.bool(forKey: "familyname")
                settingflag.givenname = UserDefaults.standard.bool(forKey: "givenname")
                settingflag.middlename = UserDefaults.standard.bool(forKey: "middlename")
                settingflag.handlename = UserDefaults.standard.bool(forKey: "handlename")
                settingflag.temp1 = UserDefaults.standard.bool(forKey: "temp1")
                settingflag.temp2 = UserDefaults.standard.bool(forKey: "temp2")
                settingflag.temp3 = UserDefaults.standard.bool(forKey: "temp3")
                settingflag.temp4 = UserDefaults.standard.bool(forKey: "temp4")
                settingflag.temp5 = UserDefaults.standard.bool(forKey: "temp5")
                settingflag.temp6 = UserDefaults.standard.bool(forKey: "temp6")
                settingflag.temp7 = UserDefaults.standard.bool(forKey: "temp7")
                settingflag.logoImageName = UserDefaults.standard.bool(forKey: "logoImageName")
                settingflag.profileImageName = UserDefaults.standard.bool(forKey: "profileImageName")

                print("appear")

            })
            .onDisappear(perform: {
                //UserDefaults.standard.set(settingflag.category, forKey: "category")
                UserDefaults.standard.set(settingflag.fullname, forKey: "fullname")
                UserDefaults.standard.set(settingflag.fullyomi, forKey: "fullyomi")
                UserDefaults.standard.set(settingflag.company1, forKey: "company1")
                UserDefaults.standard.set(settingflag.company1yomi, forKey: "company1yomi")
                UserDefaults.standard.set(settingflag.company2, forKey: "company2")
                UserDefaults.standard.set(settingflag.department, forKey: "department")
                UserDefaults.standard.set(settingflag.section, forKey: "section")
                UserDefaults.standard.set(settingflag.role, forKey: "role")
                UserDefaults.standard.set(settingflag.zipcode, forKey: "zipcode")
                UserDefaults.standard.set(settingflag.address1, forKey: "address1")
                UserDefaults.standard.set(settingflag.address2, forKey: "address2")
                UserDefaults.standard.set(settingflag.tel, forKey: "tel")
                UserDefaults.standard.set(settingflag.fax, forKey: "fax")
                UserDefaults.standard.set(settingflag.email, forKey: "email")
                UserDefaults.standard.set(settingflag.homepage, forKey: "homepage")
                UserDefaults.standard.set(settingflag.facebook, forKey: "facebook")
                UserDefaults.standard.set(settingflag.twitter, forKey: "twitter")
                UserDefaults.standard.set(settingflag.instagram, forKey: "instagram")
                UserDefaults.standard.set(settingflag.line_id, forKey: "line_id")
                UserDefaults.standard.set(settingflag.youtube, forKey: "youtube")
                UserDefaults.standard.set(settingflag.sns, forKey: "sns")
                /*
                UserDefaults.standard.set(settingflag.meeting_date  , forKey: "meeting_date  ")
                UserDefaults.standard.set(settingflag.meeting_place, forKey: "meeting_place")
                UserDefaults.standard.set(settingflag.latitude, forKey: "latitude")
                UserDefaults.standard.set(settingflag.longitude, forKey: "longitude")
                */
                UserDefaults.standard.set(settingflag.birth_date  , forKey: "birth_date  ")
                UserDefaults.standard.set(settingflag.familyname, forKey: "familyname")
                UserDefaults.standard.set(settingflag.givenname, forKey: "givenname")
                UserDefaults.standard.set(settingflag.middlename, forKey: "middlename")
                UserDefaults.standard.set(settingflag.handlename, forKey: "handlename")
                UserDefaults.standard.set(settingflag.temp1, forKey: "temp1")
                UserDefaults.standard.set(settingflag.temp2, forKey: "temp2")
                UserDefaults.standard.set(settingflag.temp3, forKey: "temp3")
                UserDefaults.standard.set(settingflag.temp4, forKey: "temp4")
                UserDefaults.standard.set(settingflag.temp5, forKey: "temp5")
                UserDefaults.standard.set(settingflag.temp6, forKey: "temp6")
                UserDefaults.standard.set(settingflag.temp7, forKey: "temp7")
                UserDefaults.standard.set(settingflag.logoImageName, forKey: "logoImageName")
                UserDefaults.standard.set(settingflag.profileImageName, forKey: "profileImageName")
                print("disappear")
            })
           //.navigationBarTitle("マイデータ転送設定")
            .navigationBarTitle("マイデータ転送設定",displayMode: .inline)
            .navigationBarItems(
                trailing:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "xmark.circle")
                        Text("閉じる")
                    })
            )
        }
    }
}

struct MyDataSettingView_Previews: PreviewProvider {
    static var previews: some View {
        MyDataSettingView()
    }
}
