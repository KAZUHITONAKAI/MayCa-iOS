import SwiftUI
import MapKit // import CoreLocation でも可


var userdata_category:String = ""

struct UserDataDetail: View {
    @State var person:UserModel
    //@Binding var person:UserModel
    @State var flg:Bool = false
    @State var categoryModels: [CategoryModel] = []
    @State private var selection = 1
    @State var options: [String] = []
    @State var showingPopUp = false
    
    @State var showingMapPopUp = false
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var sexIndex: Int = 0
    @State var deleteflg = false
    @State var showingAlert = false
    @State var errtype:Int8 = 0
    @State var title_Text = ""
    @State var message_Text = ""
    @State private var sexItem = ["男性","女性",""]
    var txt_width_out:CGFloat = screen_info.width*0.9
    // 変換対象外とする文字列（英数字と-._~）
    var allowedCharacters =  NSCharacterSet.alphanumerics.union(.init(charactersIn: "-._~"))

    //    @Binding var selected: CategoryModel = DB_ManagerCategory().getCategory(idValue: 1)
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                BusinessCardView(person: $person)
                Section(header: Text("会社 学校 所属団体　情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                    Spacer().frame(height: 20)//タイトル・コンテンツ行間
                    Text("修正を保存する場合は改行キーをタップして下さい。")
                        .font(.system(size: 14))
                        .foregroundColor(.red)
                    Spacer().frame(height: 10)//タイトル・コンテンツ行間
                    ZStack{
                        VStack {
                            Text("カテゴリ:")
                            .font(.callout)
                            .bold()
                            .frame(width: txt_width_out,alignment: .leading)
                            Button(action: {
                                showingPopUp = true
                            }) {
                                Text(person.category)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: txt_width_out, height: 30, alignment: .leading)
                                    .border(Color.gray, width: 1)
                                    .cornerRadius(5)
                                    .onChange(of: person.category, perform: setCategory)
                            }
                        }
                        if showingPopUp {
                            PopupCategoryView(isPresent: $showingPopUp, userdata_category: $person.category)
                        }
                    }
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
                    //}
                    //.padding()
                    //VStack {
                        Text("氏名　フリガナ:")
                            .font(.callout)
                            .bold()
                            .frame(width: txt_width_out,alignment: .leading)
                        TextField("氏名　フリガナ", text: $person.fullyomi, onCommit: {updateDb()})
                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    }
                    //.padding()
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
                    //}
                    //.padding()
                    //VStack {
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
                .frame(width: txt_width_out,alignment: .center)
            }//VStack
            .frame(width: screen_info.width,alignment: .center)

            VStack(alignment: .center){
                    Spacer().frame(height: 40)
                    Section(header: Text("アドレス情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        ZStack{
                            VStack {
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
                                VStack {
                                    Button(action: {
                                        print("add1")
                                        showingMapPopUp = true
                                        let address = person.address1//どこかの住所
                                        CLGeocoder().geocodeAddressString(address) { placemarks, error in
                                            if let lat = placemarks?.first?.location?.coordinate.latitude {
                                                print("緯度 : \(lat)")
                                                self.latitude = String(lat)
                                            }
                                            if let lng = placemarks?.first?.location?.coordinate.longitude {
                                                print("経度 : \(lng)")
                                                self.longitude = String(lng)
                                            }
                                        }
                                    }, label: {
                                        Text("住所1:")
                                            .font(.callout)
                                            .foregroundColor(Color.blue)
                                            .bold()
                                            .frame(width: txt_width_out,alignment: .leading)
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                    TextField("住所1", text: $person.address1, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                VStack {
                                    Button(action: {
                                        print("add2")
                                        showingMapPopUp = true
                                        let address = person.address2//どこかの住所
                                        CLGeocoder().geocodeAddressString(address) { placemarks, error in
                                            if let lat = placemarks?.first?.location?.coordinate.latitude {
                                                print("緯度 : \(lat)")
                                                self.latitude = String(lat)
                                            }
                                            if let lng = placemarks?.first?.location?.coordinate.longitude {
                                                print("経度 : \(lng)")
                                                self.longitude = String(lng)
                                            }
                                        }
                                    }, label: {
                                        Text("住所2:")
                                            .font(.callout)
                                            .foregroundColor(Color.blue)
                                            .bold()
                                            .frame(width: txt_width_out,alignment: .leading)
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                    TextField("住所2", text: $person.address2, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                VStack {
                                    if person.facebook.contains(" ") {
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
                                        Link("E-mail:", destination: URL(string: AppSNSLink.link_email+person.email)!)
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
                                            Link("URL:", destination: URL(string: person.homepage)!)
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
                            }//VStack
                            if showingMapPopUp {
                                PopUpMapView(latitude: latitude, longitude: longitude, isPresent: $showingMapPopUp)
                            }
                        }//ZStack
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
                            HStack{
                                Text("LINE ID:")
                                    .font(.callout)
                                    //.bold()
                                    .foregroundColor(.blue)
                                    .frame(width: txt_width_out*0.4,alignment: .leading)
                                    .contextMenu{
                                        Text("IDもしくは電話番号をLINE内で検索して下さい")
                                            .font(.system(size: 10))
                                        Button(action: {
                                            UIPasteboard.general.string = person.line_id
                                        }){
                                            Label("IDをコピー", systemImage:"doc.on.doc")
                                        }
                                    }
                                Spacer()
                                Link("友達追加", destination: URL(string: AppSNSLink.link_lineadd)!)
                                    .frame(width: txt_width_out*0.4,alignment: .trailing)
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
                    Spacer().frame(height: 40)
                    Section(header: Text("名刺交換情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        Spacer().frame(height: 20)//タイトル・コンテンツ行間
                        ZStack{
                            VStack {
                                MapView(latitude: person.latitude,longitude: person.longitude)
                                        .edgesIgnoringSafeArea(.top)
                                        .frame(height: 200)

                                VStack {
                                    Text("名刺交換日:")
                                        .font(.callout)
                                        .bold()
                                        .frame(width: txt_width_out,alignment: .leading)
                                    TextField("名刺交換日", text: $person.meeting_date_str, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                VStack {
                                    Text("名刺交換場所:")
                                        .font(.callout)
                                        .bold()
                                        .frame(width: txt_width_out,alignment: .leading)
                                    TextField("名刺交換場所", text: $person.meeting_place, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                VStack {
                                    Text("名刺交換緯度:")
                                        .font(.callout)
                                        .bold()
                                        .frame(width: txt_width_out,alignment: .leading)
                                    TextField("名刺交換緯度", text: $person.latitude, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                
                                }
                                //.padding()
                                VStack {
                                    Text("名刺交換経度:")
                                        .font(.callout)
                                        .bold()
                                        .frame(width: txt_width_out,alignment: .leading)
                                    TextField("名刺交換経度", text: $person.longitude, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                
                                }
                                //.padding()
                            }//VStack
                        }//ZStack
                    }//Section
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
                        }
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
                        }*/
                    }//Section
                    Spacer().frame(height: 40)
                    ZStack {
	                    HStack {
	                        Spacer()
	                        //削除
	                        if person.id > 1 {
	                            VStack{
                                    /*
	                                Image("delete")
	                                    .onLongPressGesture {
	                                        DB_Manager().deleteUser(idValue: person.id)
	                                        // go back to home page
	                                        self.mode.wrappedValue.dismiss()
	                                        print("delete")
	                                    }
                                    */
	                                Text("長押し削除")
                                        .foregroundColor(.blue)
	                                    .onLongPressGesture {
	                                        DB_Manager().deleteUser(idValue: person.id)
	                                        // go back to home page
	                                        self.mode.wrappedValue.dismiss()
	                                        print("delete")
	                                    }
	                                    //.font(.system(size: 12))
	                                    //.foregroundColor(.red)
	                            }
	                            /*
	                            NavigationLink(destination: EmptyView()) {
	                                Button(action: {
	                                    DB_Manager().deleteUser(idValue: person.id)
	                                    // go back to home page
	                                    self.mode.wrappedValue.dismiss()
	                                    print("delete")
	                                }) {
	                                    CircleImage(image: Image("delete"))
	                                }
	                            }*/
	                        }
                            /*
                            NavigationLink(destination: EmptyView()) {
                                Button(action: {
                                    updateDb()
                                }) {
                                    Text("マイデータ保存")
                                        //.font(.system(size: 12))
                                    //Image("save")
                                }
                            }*/
                        }//HStack
                    }//ZStack
                    Spacer().frame(height: 20)//タイトル・コンテンツ行間
            }//VStack
            .frame(width: txt_width_out,alignment: .leading)
        }//ScrollView
        .background(Image("background_image_l2").resizable().scaledToFill().opacity(0.1))
        .onAppear(perform: {
            self.categoryModels = DB_ManagerCategory().getCategories()
            var i = 0
            self.selection = i
            for category in self.categoryModels {
            //ForEach(self.categoryModels) { category in {
                self.options.append(category.category)
                if person.category == category.category {
                    self.selection = i
                }
                i = i + 1
            }
            userdata_category = person.category
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

        .navigationBarTitle("名刺交換データ")
    }//body

    func updateDb() {
        self.errtype = checkProfibitSpace(userdata:person)
        self.showingAlert = setAlertMsg(errtype: self.errtype, title: &self.title_Text, message: &self.message_Text)
        if self.showingAlert {
            print("space error")
            return
        }
        DB_Manager().updateUser(idValue: person.id, categoryValue:person.category, fullnameValue:person.fullname, fullyomiValue:person.fullyomi, company1Value:person.company1, company1yomiValue:person.company1yomi, company2Value:person.company2, departmentValue:person.department, sectionValue:person.section, roleValue:person.role, zipcodeValue:person.zipcode, address1Value:person.address1, address2Value:person.address2, telValue:person.tel, faxValue:person.fax, emailValue: person.email, homepageValue:person.homepage, facebookValue:person.facebook, twitterValue:person.twitter, instagramValue:person.instagram, line_idValue:person.line_id, youtubeValue:person.youtube, snsValue:person.sns, meeting_date_strValue:person.meeting_date_str, meeting_placeValue:person.meeting_place, latitudeValue:person.latitude, longitudeValue:person.longitude, birth_date_strValue:person.birth_date_str, familynameValue:person.familyname, givennameValue:person.givenname, middlenameValue:person.middlename, handlenameValue:person.handlename, temp1Value:person.temp1, temp2Value:person.temp2, temp3Value:person.temp3, temp4Value:person.temp4, temp5Value:person.temp5, temp6Value:person.temp6, temp7Value:person.temp7, logoImageNameValue:person.logoImageName, profileImageNameValue:person.profileImageName)
        print("save")
        person = DB_Manager().getUser(idValue: Int64(person.id))
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
        updateDb()
        print("sex : \(tag) \(person.temp7)")
    }
}


/*
struct UserDataDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDataDetail(person: UserModel)
    }
}
*/
