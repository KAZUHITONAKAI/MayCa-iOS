//
//  MyDataView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/05/01.
//

import SwiftUI
import UIKit
//import Firebase
//import FirebaseFirestore
//import FirebaseAuth

struct MyDataView: View {
//    @State var userdata:UserData = UserData()
//    @State var userdata:UserModel
//    var person: PersonData = personData[0]
    @Binding var person: UserModel// = DB_Manager().getUser(idValue: Int64(g_index))
    @State var userdatas: [UserDataModel] = []
    @State var sexIndex: Int = 0
    @State private var sexItem = ["男性","女性",""]
    @State private var image: UIImage?
    @State var urlstr: String = ""
    @State var showingLogoImagePicker = false
    @State var showingProfileImagePicker = false
    @State var isActiveUserDataView = false
    @State var logo_image:UIImage?
    @State var profile_image:UIImage?
    @State var image_str:String = ""
    @State var isActiveMyDataSettingView = false
    @State var showingAlert = false
    @State var errtype:Int8 = 0
    @State var title_Text = ""
    @State var message_Text = ""
    var txt_width_out:CGFloat = screen_info.width*0.9
    // 変換対象外とする文字列（英数字と-._~）
    var allowedCharacters =  NSCharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))

    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                BusinessCardView(person: $person)
                Section(header: Text("必須情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                    Spacer().frame(height: 20)//タイトル・コンテンツ行間
                    Text("保存するには右上または画面右下の保存ボタンをタップして下さい。")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                    Spacer().frame(height: 10)//タイトル・コンテンツ行間
                    VStack {
                        //Spacer()
                        Text("氏名:")
                            .font(.callout)
                            //.foregroundColor(.red)
                            .bold()
                            .frame(width: txt_width_out,alignment: .leading)
                        TextField("氏名", text: $person.fullname, onCommit: {updateDb()})
                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        //Spacer()
                    }
                    //.padding()
                    VStack {
                        Text("氏名　フリガナ:")
                            .font(.callout)
                            .bold()
                            .frame(width: txt_width_out,alignment: .leading)
                        TextField("氏名　フリガナ", text: $person.fullyomi, onCommit: {updateDb()})
                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    }
                    //.padding()
                }//Section
                .frame(width: txt_width_out,alignment: .center)
            }//VStack
            //.frame(width: txt_width_out,alignment: .center)
            .frame(width: screen_info.width,alignment: .center)

            VStack(alignment: .center){
                    Spacer().frame(height: 40)
                    Section(header: Text("会社 学校 所属団体　情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        VStack {
                            //Spacer()
                            Text("会社 学校 所属団体:")
                                .font(.callout)
                                //.foregroundColor(.red)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("会社 学校 所属団体", text: $person.company1, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            //Spacer()
                        }
                        //.padding()
                        VStack {
                            Text("会社 学校 所属団体　フリガナ:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("会社 学校 所属団体　フリガナ", text: $person.company1yomi, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Text("会社 学校 所属団体（２段目）:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("会社 学校 所属団体（２段目）", text: $person.company2, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Text("所属部署（部）　クラス:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("所属部署（部）　クラス", text: $person.department, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Text("所属部署（課）　クラス:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("所属部署（課）　クラス", text: $person.section, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Text("役職:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("役職", text: $person.role, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                    }//Section
                    Spacer().frame(height: 40)
                    Section(header: Text("アドレス情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        VStack {
                            Text("郵便番号:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("郵便番号", text: $person.zipcode,
                                onEditingChanged: { begin in
                                    /// 入力終了処理
                                    if begin == false {
                                        updateDb()
                                    }
                                },
                                onCommit: {updateDb()})
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Text("住所1:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("住所1", text: $person.address1, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Text("住所2:")
                                .font(.callout)
                                .bold()
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("住所2", text: $person.address2, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.tel.contains(" ") {
                                Text("TEL:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                Link("TEL:", destination: URL(string: AppSNSLink.link_tel+person.tel)!)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("TEL", text: $person.tel,
                                onEditingChanged: { begin in
                                    /// 入力終了処理
                                    if begin == false {
                                        updateDb()
                                    }
                                },
                                onCommit: {updateDb()})
                                .keyboardType(.phonePad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.temp6.contains(" ") {
                                Text("Mobile Phone:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                Link("Mobile Phone:", destination: URL(string: AppSNSLink.link_tel+person.temp6)!)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("携帯電話番号", text: $person.temp6,
                                onEditingChanged: { begin in
                                    /// 入力終了処理
                                    if begin == false {
                                        updateDb()
                                    }
                                },
                                onCommit: {updateDb()})
                                .keyboardType(.phonePad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.fax.contains(" ") {
                                Text("FAX:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                Link("FAX:", destination: URL(string: AppSNSLink.link_fax+person.fax)!)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("FAX", text: $person.fax,
                                onEditingChanged: { begin in
                                    /// 入力終了処理
                                    if begin == false {
                                        updateDb()
                                    }
                                },
                                onCommit: {updateDb()})
                                .keyboardType(.phonePad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.email.contains(" ") {
                                Text("E-mail:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                // 変換処理
                                let email_url = URL(string: AppSNSLink.link_email + person.email.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
                                Link("E-mail:", destination: email_url)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("E-mail", text: $person.email, onCommit: {updateDb()})
                                .keyboardType(.emailAddress)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.homepage.count > 0 {
                                if person.homepage.contains(" ") {
                                    Text("URL:")
                                        .font(.callout)
                                        .bold()
                                        .frame(width: txt_width_out,alignment: .leading)
                                }else{
                                    // 変換処理
                                    let homepage_url = URL(string: person.homepage.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
                                    Link("URL:", destination: homepage_url)
                                        .frame(width: txt_width_out,alignment: .leading)
                                }
                            }else{
                                Text("URL:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("URL", text: $person.homepage, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                    }//Section
            }//VStack
            .frame(width: txt_width_out,alignment: .leading)

            VStack(alignment: .center){
                    Spacer().frame(height: 40)
                    Section(header: Text("SNS情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        Text("BOX内にはID又はユーザーネームのみ記入して下さい")
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(width: txt_width_out,alignment: .center)
                        Spacer().frame(height: 10)//タイトル・コンテンツ行間

                        VStack {
                            if person.facebook.contains(" ") {
                                Text("facebook:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                // 変換処理
                                let facebook_url = URL(string: AppSNSLink.link_facebook + person.facebook.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
                                Link("facebook:", destination: facebook_url)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("facebook", text: $person.facebook, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.instagram.contains(" ") {
                                Text("instagram:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                // 変換処理
                                let instagram_url = URL(string: AppSNSLink.link_instagram + person.instagram.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
                                Link("instagram:", destination: instagram_url)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("instagram", text: $person.instagram, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.twitter.contains(" ") {
                                Text("twitter:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                // 変換処理
                                let twitter_url = URL(string: AppSNSLink.link_twitter + person.twitter.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
	                            Link("twitter:", destination: twitter_url)
	                                .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("twitter", text: $person.twitter, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            Link("LINE:", destination: URL(string: AppSNSLink.link_lineprofile)!)
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("LINE ID", text: $person.line_id, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            if person.youtube.contains(" ") {
                                Text("YouTube:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                // 変換処理
                                let youtube_url = URL(string: AppSNSLink.link_YouTube + person.youtube.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
                                Link("YouTube:", destination: youtube_url)
                                    .frame(width: txt_width_out,alignment: .leading)
                            }
                            TextField("YouTube", text: $person.youtube, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        VStack {
                            // 変換処理
                            let sns_url = URL(string: AppSNSLink.link_sns + person.sns.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
                            Link("SNS:", destination: sns_url)
                                .frame(width: txt_width_out,alignment: .leading)
                            TextField("SNS", text: $person.sns, onCommit: {updateDb()})
                                .keyboardType(.URL)
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                    }//Section
            }//VStack
            .frame(width: txt_width_out,alignment: .leading)

            VStack(alignment: .center){
                    /*
                    Group{
                            MapView(latitude: person.latitude,longitude: person.longitude)
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 200)

                        HStack {
                            Text("名刺交換日:")
                                .font(.callout)
                                .bold()
                            TextField("名刺交換日", text: $person.meeting_date_str, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("名刺交換場所:")
                                .font(.callout)
                                .bold()
                            TextField("名刺交換場所", text: $person.meeting_place, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("名刺交換緯度:")
                                .font(.callout)
                                .bold()
                            TextField("名刺交換緯度", text: $person.latitude, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
        
                        }
                        //.padding()
                        HStack {
                            Text("名刺交換経度:")
                                .font(.callout)
                                .bold()
                            TextField("名刺交換経度", text: $person.longitude, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
        
                        }
                        //.padding()
                    }//Group
                    */
                    //広告ビュー
                    AdView()
                    Spacer().frame(height: 40)
                    Section(header: Text("個人情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        HStack {
                            Text("姓:")
                                .font(.callout)
                                .bold()
                            TextField("姓", text: $person.familyname, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("名:")
                                .font(.callout)
                                .bold()
                            TextField("名", text: $person.givenname, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("ミドルネーム:")
                                .font(.callout)
                                .bold()
                            TextField("ミドルネーム", text: $person.middlename, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("ハンドルネーム:")
                                .font(.callout)
                                .bold()
                            TextField("ハンドルネーム", text: $person.handlename, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("誕生日:")
                                .font(.callout)
                                .bold()
                            TextField("誕生日", text: $person.birth_date_str, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        HStack {
                            Text("性別:")
                                .font(.callout)
                                .bold()
                            Picker("", selection: self.$sexIndex) {
                                Text("男性")
                                    .tag(0)
                                Text("女性")
                                    .tag(1)
                                Text("非公開")
                                    .tag(2)
                            }
                            .onChange(of: self.sexIndex) { tag in
                                sexChange(tag)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        //.padding()
                    }//Section
                    Spacer().frame(height: 40)
                    Section(header: Text("その他情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        HStack {
                            Text("任意1:")
                                .font(.callout)
                                .bold()
                            TextField("任意1", text: $person.temp1, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("任意2:")
                                .font(.callout)
                                .bold()
                            TextField("任意2", text: $person.temp2, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("任意3:")
                                .font(.callout)
                                .bold()
                            TextField("任意3", text: $person.temp3, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("任意4:")
                                .font(.callout)
                                .bold()
                            TextField("任意4", text: $person.temp4, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        HStack {
                            Text("任意5:")
                                .font(.callout)
                                .bold()
                            TextField("任意5", text: $person.temp5, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        /*
                        HStack {
                            Text("任意6:")
                                .font(.callout)
                                .bold()
                            TextField("任意6", text: $person.temp6, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        //.padding()
                        //性別
                        HStack {
                            Text("任意7:")
                                .font(.callout)
                                .bold()
                            TextField("任意7", text: $person.temp7, onCommit: {updateDb()})
                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }*/
                        //.padding()
                        HStack {
                            Button(action: {
                                showingLogoImagePicker = true
                            }) {
                                Text("会社ロゴファイル名:")
                                    .font(.callout)
                                    .bold()
                            }
                            //TextField("会社ロゴファイル名", text: $person.logoImageName, onCommit: {updateDb()})
                            //    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        if let uiImage = logo_image {
                            Image(uiImage: uiImage)
                                .resizable()
                                //.scaledToFit()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                //.clipShape(Circle())
                            
                        } else {
                            Image("MayCa256")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .clipShape(Circle())
                        }
                        //.padding()
                        HStack {
                            Button(action: {
                                showingProfileImagePicker = true
                            }) {
                                Text("顔写真ファイル名:")
                                    .font(.callout)
                                    .bold()
                            }
                            //Text("顔写真ファイル名:")
                            //    .font(.callout)
                            //    .bold()
                            //TextField("顔写真ファイル名", text: $person.profileImageName, onCommit: {updateDb()})
                            //    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                        }
                        if let uiImage = profile_image {
                            Image(uiImage: uiImage)
                                .resizable()
                                //.scaledToFit()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                                //.clipShape(Circle())
                            
                        } else {
                            Image("avater")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .clipShape(Circle())
                        }
                    }//Section
                    Spacer().frame(height: 40)
                    Section(header: Text("非公開データ情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        VStack {
                            //ユーザデータ情報
                            ForEach (self.userdatas) { userdata in
                                HStack {
                                    Text(userdata.userkey)
                                    TextField(userdata.userkey,
                                            text: Binding(get: { userdata.uservalue }, set: { userdata.uservalue = $0 }),
                                        onCommit: {
                                            updateUserDataDb(userdata: userdata)
                                        }
                                    )
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                            }
                            Button(action: {
                                self.isActiveUserDataView.toggle()
                                print("")
                            }) {
                                Text("非公開データ追加")
                            }
                        }
                    }//Section

                    Spacer().frame(height: 40)
                    ZStack {
                        HStack {
                            Button(action: {
                                //マイデータ転送設定
                                self.isActiveMyDataSettingView.toggle()
                            }, label: {
                                Text("マイデータ転送設定")
                                    //.font(.system(size: 12))
                            })
                            Spacer()
                            //保存
                            NavigationLink(destination: EmptyView()) {
                                Button(action: {
                                    updateDb()
                                    //self.isActiveMyDataSettingView.toggle()
                                }) {
                                    Text("マイデータ保存")
                                        //.font(.system(size: 12))
                                    //Image("save")
                                }
                            }
                        }
                    }//ZStack
                    Spacer().frame(height: 40)
            }//VStack
            .frame(width: txt_width_out,alignment: .leading)
            //ナビゲーションの部分にアイコン・ボタンを追加
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        updateDb()
                        self.isActiveMyDataSettingView.toggle()
                        print("save")
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                        Text("保存")
                    })
                }
            )
        }//ScrollView
        .background(Image("background_image_l2").resizable().scaledToFill().opacity(0.1))
        //.frame(width: screen_info.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onAppear(perform: {
            //person = DB_Manager().getUser(idValue: g_index)
            userdatas = DB_ManagerUserData().getUserDatas()
            print("@MyDataView onAppear")
            if person.temp7 == "男性" {
                self.sexIndex = 0
            }else if person.temp7 == "女性" {
                self.sexIndex = 1
            }else{
                self.sexIndex = 2
            }
            //顔写真データのロード
            let profile_path:String = UserDefaults.standard.string(forKey: "avater") ?? "avater"
            print("path:\(profile_path)")
            profile_image = loadImageFromPath(path: profile_path)
            if profile_image == nil {
                print("profile_image :\(profile_image)")
            }else{
                print("profile_image画像取得できたよ")
            }
            //会社ロゴデータのロード
            let logo_path = UserDefaults.standard.string(forKey: "logo") ?? "logo"
            print("path:\(logo_path)")
            logo_image = loadImageFromPath(path: logo_path)
            if logo_image == nil {
                print("logo_image :\(logo_image)")
            }else{
                print("logo_image画像取得できたよ")
            }
        })
        .onDisappear(perform: {
            person = DB_Manager().getUser(idValue: g_index)
            print("@MyDataView onDisappear")
            if person.temp7 == "男性" {
                self.sexIndex = 0
            }else if person.temp7 == "女性" {
                self.sexIndex = 1
            }else{
                self.sexIndex = 2
            }
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(title_Text), message: Text(message_Text))
        }
        .sheet(isPresented: $showingLogoImagePicker,
               /*画面を閉じた時に実行する処理を指定*/
               onDismiss: {
                    image_str = UserDefaults.standard.string(forKey: "logo") ?? "logo"
                    print(image_str)
                   print("画面を閉じた")
                   }
               ) {
            ImagePickerView(image: self.$logo_image, image_type: "logo")
        }
        .sheet(isPresented: $showingProfileImagePicker,
               /*画面を閉じた時に実行する処理を指定*/
               onDismiss: {
                    image_str = UserDefaults.standard.string(forKey: "avater") ?? "avater"
                    print(image_str)
                   print("画面を閉じた")
                   }
               ) {
            ImagePickerView(image: self.$profile_image, image_type: "avater")
        }
        .sheet(isPresented: $isActiveUserDataView) {
        //    AddUserDataView()
            UserDataEditView(userdatas: $userdatas)
        }
        .sheet(
            isPresented: $isActiveMyDataSettingView
        ) {
            MyDataSettingView()
        }
        /*
        //ナビゲーションの部分にアイコン・ボタンを追加
        .navigationBarItems(trailing: 
            HStack {
                Button(action: {
                    //マイデータ転送設定
                    self.isActiveMyDataSettingView.toggle()
                    print("右のボタン２が押されました。")
                }, label: {
                    Image(systemName: "gearshape.2.fill")
                })
                Spacer()
            }
        )*/

        .navigationBarTitle("マイデータ")
    }

    func updateDb() {
        print("url: \(person.logoImageName)")
        if person.fullname.count > 0 && person.fullyomi.count > 0 {
            self.errtype = checkProfibitSpace(userdata:person)
            self.showingAlert = setAlertMsg(errtype: self.errtype, title: &self.title_Text, message: &self.message_Text)
            if self.showingAlert {
                return
            }
            if person.id == 0 {
                DB_Manager().addUser(categoryValue:person.category, fullnameValue:person.fullname, fullyomiValue:person.fullyomi, company1Value:person.company1, company1yomiValue:person.company1yomi, company2Value:person.company2, departmentValue:person.department, sectionValue:person.section, roleValue:person.role, zipcodeValue:person.zipcode, address1Value:person.address1, address2Value:person.address2, telValue:person.tel, faxValue:person.fax,emailValue: person.email, homepageValue:person.homepage, facebookValue:person.facebook, twitterValue:person.twitter, instagramValue:person.instagram, line_idValue:person.line_id, youtubeValue:person.youtube, snsValue:person.sns, meeting_date_strValue:person.meeting_date_str, meeting_placeValue:person.meeting_place, latitudeValue:person.latitude, longitudeValue:person.longitude, birth_date_strValue:person.birth_date_str, familynameValue:person.familyname, givennameValue:person.givenname, middlenameValue:person.middlename, handlenameValue:person.handlename, temp1Value:person.temp1, temp2Value:person.temp2, temp3Value:person.temp3, temp4Value:person.temp4, temp5Value:person.temp5, temp6Value:person.temp6, temp7Value:person.temp7, logoImageNameValue:person.logoImageName, profileImageNameValue:person.profileImageName)

            }else{
                DB_Manager().updateUser(idValue: person.id, categoryValue:person.category, fullnameValue:person.fullname, fullyomiValue:person.fullyomi, company1Value:person.company1, company1yomiValue:person.company1yomi, company2Value:person.company2, departmentValue:person.department, sectionValue:person.section, roleValue:person.role, zipcodeValue:person.zipcode, address1Value:person.address1, address2Value:person.address2, telValue:person.tel, faxValue:person.fax, emailValue: person.email, homepageValue:person.homepage, facebookValue:person.facebook, twitterValue:person.twitter, instagramValue:person.instagram, line_idValue:person.line_id, youtubeValue:person.youtube, snsValue:person.sns, meeting_date_strValue:person.meeting_date_str, meeting_placeValue:person.meeting_place, latitudeValue:person.latitude, longitudeValue:person.longitude, birth_date_strValue:person.birth_date_str, familynameValue:person.familyname, givennameValue:person.givenname, middlenameValue:person.middlename, handlenameValue:person.handlename, temp1Value:person.temp1, temp2Value:person.temp2, temp3Value:person.temp3, temp4Value:person.temp4, temp5Value:person.temp5, temp6Value:person.temp6, temp7Value:person.temp7, logoImageNameValue:person.logoImageName, profileImageNameValue:person.profileImageName)
            }
        }else{
            Alert(title: Text("必須項目エラー"), message: Text("氏名とフリガナは必須項目です。"))
        }

        /*
        Auth.auth().signInAnonymously{ (result, error) in
            if result != nil {
                
            }else{
                
            }
        }*/ //20210816
        /*
        var profile:Array = UIImage(data: "gana")
        var logodata:Array = UIImage(data: "avater")
         */
        //FirebaseCloudへのパス
        //let db = Firebase.Firestore.firestore() //20210816
        /*
        db.collection("Users").document(Auth.auth().currentUser!.uid).setData(
            ["Profile":profile, "Logo":logodata]
        ) //.collection("Profile").setValue(Any?, forKey: <#T##String#>)
        */
        person = DB_Manager().getUser(idValue: Int64(g_index))
        print("save")
    }

    func updateUserDataDb(userdata: UserDataModel) {
        DB_ManagerUserData().updateUserData(idValue: userdata.id, userkeyValue: userdata.userkey, uservalueValue: userdata.uservalue)
        print("updated")
    }

    func sexChange(_ tag: Int) {
        person.temp7 = sexItem[tag]
        updateDb()
        print("sex : \(tag) \(person.temp7)")
    }

    func isAlphanumeric(target: String) -> Bool
    {
        // ② 検索するパターン
        let pattern = "[^0-9]+"

        // ③ NSRegularExpressionのインスタンス生成
        let regex = try! NSRegularExpression(pattern: pattern, options: [])

        // ④ 検索実行
        let results = regex.matches(in: target, options: [], range: NSRange(0..<target.count))
        return true
    }

}
/*
struct MyDataView_Previews: PreviewProvider {
    static var previews: some View {
        MyDataView()
    }
}
*/
