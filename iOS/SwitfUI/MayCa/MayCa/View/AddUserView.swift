//
//  AddUserView.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import SwiftUI
import MapKit // import CoreLocation でも可

struct AddUserView: View {
    @State var person: UserModel = UserModel()
    @State var sexIndex: Int = 0
    @State private var sexItem = ["男性","女性",""]
    @State var showingPopUp = false
    @State var showingAlert = false
    @State var errtype:Int8 = 0
    @State var title_Text = ""
    @State var message_Text = ""
    var txt_width_out:CGFloat = screen_info.width*0.9
    // 変換対象外とする文字列（英数字と-._~）
    var allowedCharacters =  NSCharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        ScrollView{
            VStack {
                //広告ビュー
                AdView()
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
            }//VStack
            .frame(width: txt_width_out,alignment: .leading)

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
                            if person.line_id.contains(" ") {
                                Text("LINE:")
                                    .font(.callout)
                                    .bold()
                                    .frame(width: txt_width_out,alignment: .leading)
                            }else{
                                // 変換処理
                                let line_url = URL(string: AppSNSLink.link_line + person.line_id.addingPercentEncoding(withAllowedCharacters: allowedCharacters)!)!
	                            Link("LINE:", destination: line_url)
	                                .frame(width: txt_width_out,alignment: .leading)
                            }

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
                        /*
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
                        }*/
                    }//Section
                    /*
                    Spacer().frame(height: 40)
                    Section(header: Text("非公開データ情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                    }//Section
                    */
                    Spacer().frame(height: 40)
                    HStack {
                        Spacer()
                        //保存
                        NavigationLink(destination: EmptyView()) {
                            Button(action: {
                                saveDb()
                                print("save")
                            }) {
                                Image(systemName: "square.and.arrow.down")
                                Text("保存")
                                //.font(.system(size: 14))
                                //Image("save")
                            }
                        }
                    }
                    Spacer().frame(height: 40)
            }//VStack
            .frame(width: txt_width_out,alignment: .trailing)
            .navigationBarTitle("ユーザ追加").font(.system(size: 18))
            //ナビゲーションの部分にアイコン・ボタンを追加
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        saveDb()
                        print("save")
                    }, label: {
                        Image(systemName: "square.and.arrow.down")
                        Text("保存")
                    })
                }
            )
        }//ScrollView
        .background(Image("background_image_l2").resizable().scaledToFill().opacity(0.1))
        .onAppear(perform: {
            self.sexIndex = 2
            person.latitude = String(location.latitude)
            person.longitude = String(location.longitude)
            let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first, error == nil else { return }
                //緯度経度から住所取得
                //print(placemark.location)
                //print(placemark.locality)
                //print(placemark.administrativeArea)
                //print(placemark.subAdministrativeArea)
                //print(placemark.name)
                var locality:String = ""
                var local_name:String = ""
                if placemark.locality != nil {
                    locality = placemark.locality!
                }
                if placemark.name != nil {
                    local_name = placemark.name!
                }

                person.meeting_place = "手動追加@" + locality + local_name
            }
            let date = Date()
            print(date)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let datestr = dateFormatter.string(from: date)
            print(datestr)
            person.meeting_date_str = datestr
        })
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(title_Text), message: Text(message_Text))
        }
    }

    func saveDb() {
        if person.fullname.count > 0 && person.fullyomi.count > 0
            /*&& person.tel.count > 0 && person.email.count > 0*/ {
            if person.profileImageName.count == 0 {
                if person.temp7 == "男性" {
                    person.profileImageName = "avatar"
                }else if person.temp7 == "女性" {
                    person.profileImageName = "avatar_f"
                }else{
                    person.profileImageName = ""
                }
            }
            self.errtype = checkProfibitSpace(userdata:person)
            self.showingAlert = setAlertMsg(errtype: self.errtype, title: &self.title_Text, message: &self.message_Text)
            if showingAlert {
                return
            }
            DB_Manager().addUser(categoryValue:person.category, fullnameValue:person.fullname, fullyomiValue:person.fullyomi, company1Value:person.company1, company1yomiValue:person.company1yomi, company2Value:person.company2, departmentValue:person.department, sectionValue:person.section, roleValue:person.role, zipcodeValue:person.zipcode, address1Value:person.address1, address2Value:person.address2, telValue:person.tel, faxValue:person.fax,emailValue: person.email, homepageValue:person.homepage, facebookValue:person.facebook, twitterValue:person.twitter, instagramValue:person.instagram, line_idValue:person.line_id, youtubeValue:person.youtube, snsValue:person.sns, meeting_date_strValue:person.meeting_date_str, meeting_placeValue:person.meeting_place, latitudeValue:person.latitude, longitudeValue:person.longitude, birth_date_strValue:person.birth_date_str, familynameValue:person.familyname, givennameValue:person.givenname, middlenameValue:person.middlename, handlenameValue:person.handlename, temp1Value:person.temp1, temp2Value:person.temp2, temp3Value:person.temp3, temp4Value:person.temp4, temp5Value:person.temp5, temp6Value:person.temp6, temp7Value:person.temp7, logoImageNameValue:person.logoImageName, profileImageNameValue:person.profileImageName)
            // go back to home page
            self.mode.wrappedValue.dismiss()
            print("saveDb saved")
        }else{
            self.errtype = 5
            self.showingAlert = setAlertMsg(errtype: self.errtype, title: &self.title_Text, message: &self.message_Text)
            print("saveDb not saved")
        }
    }

    func updateDb() {
        self.errtype = checkProfibitSpace(userdata:person)
        self.showingAlert = setAlertMsg(errtype: self.errtype, title: &self.title_Text, message: &self.message_Text)
        print("updateDb() nothing to do")
    }

    func setCategory(category:String) {
        person.category = category
        print("category : \(person.category)")
        updateDb()
    }

    func sexChange(_ tag: Int) {
        person.temp7 = sexItem[tag]
        if person.profileImageName.count == 0 {
            if person.temp7 == "男性" {
                person.profileImageName = "avatar"
            }else if person.temp7 == "女性" {
                person.profileImageName = "avatar_f"
            }
        }
        print("sex : \(tag) \(person.temp7)")
    }

}
//var person: PersonData = personData[0]
