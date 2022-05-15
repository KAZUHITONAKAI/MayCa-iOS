import SwiftUI
import MapKit // import CoreLocation でも可


var userdata_category:String = ""

struct UserDataDetail: View {
    //var person: UserModel
    @State var userdata:UserModel
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
    @State private var sexItem = ["男性","女性",""]

    //    @Binding var selected: CategoryModel = DB_ManagerCategory().getCategory(idValue: 1)
    // to go back to previous view
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        ScrollView{
            VStack(alignment: .center){
                VStack{
                    Spacer()
                    //名刺イメージ
                    BusinessCardView(person: $userdata)
                    Spacer()
                }
                //10個以上の場合は、Groupを使う事で解消しました。
				Group{
					Section(header: Text("会社情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        ZStack{
                            VStack {
                                /*NavigationLink(
                                    /*destination:CategoryRegistView(category: userdata.category).onDisappear(perform: {
                                        print("遷移先:" + g_category)
                                        userdata.category = g_category
                                    }),*/
                                    destination:DropdownPicker(title:userdata.category, selection: $selection, options: options),
                                    isActive:$flg
                                ) {
                                    EmptyView()
                                }*/
                                ZStack{
                                    HStack {
                                        Text("カテゴリ:")
                                        .font(.callout)
                                        .bold()
                                        TextField("カテゴリ", text: $userdata.category)
                                            .onLongPressGesture {
                                                showingPopUp = true
                                            }
                                            .onChange(of: userdata.category, perform: setCategory)
                                            .environment(\.isEnabled, true)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    if showingPopUp {
                                        PopupCategoryView(isPresent: $showingPopUp, userdata_category: $userdata.category)
                                    }
                                }
                                //.padding()
                                HStack {
                                    Text("氏名:")
                                        .font(.callout)
                                        .bold()
                                    TextField("氏名", text: $userdata.fullname, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("フリガナ:")
                                        .font(.callout)
                                        .bold()
                                    TextField("フリガナ", text: $userdata.fullyomi, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("会社名1:")
                                        .font(.callout)
                                        .bold()
                                    TextField("会社名1", text: $userdata.company1, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("フリガナ:")
                                        .font(.callout)
                                        .bold()
                                    TextField("フリガナ", text: $userdata.company1yomi, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("会社名2:")
                                        .font(.callout)
                                        .bold()
                                    TextField("会社名2", text: $userdata.company2, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("所属部署（部）:")
                                        .font(.callout)
                                        .bold()
                                    TextField("所属部署（部）", text: $userdata.department, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("所属部署（課）:")
                                        .font(.callout)
                                        .bold()
                                    TextField("所属部署（課）", text: $userdata.section, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("役職:")
                                        .font(.callout)
                                        .bold()
                                    TextField("役職", text: $userdata.role, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                            }//VStack
                        }//ZStack
                    }//Section
                    //広告ビュー
                    AdView()
                    Section(header: Text("住所情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        ZStack{
                            VStack {
                                Group{
                                    HStack {
                                        Text("郵便番号:")
                                            .font(.callout)
                                            .bold()
                                        TextField("郵便番号", text: $userdata.zipcode, onCommit: {updateDb()})
                                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    //.padding()
                                    HStack {
                                        Button(action: {
                                            print("add1")
                                            showingMapPopUp = true
                                            let address = userdata.address1//どこかの住所
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
                                        })
                                        .buttonStyle(PlainButtonStyle())
                                        TextField("住所1", text: $userdata.address1, onCommit: {updateDb()})
                                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    //.padding()
                                    HStack {
                                        Button(action: {
                                            print("add2")
                                            showingMapPopUp = true
                                            let address = userdata.address2//どこかの住所
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
                                        })
                                        .buttonStyle(PlainButtonStyle())
                                        TextField("住所2", text: $userdata.address2, onCommit: {updateDb()})
                                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    //.padding()
                                    HStack {
                                        Link("TEL:", destination: URL(string: "tel://"+userdata.tel)!)
                                        TextField("TEL", text: $userdata.tel, onCommit: {updateDb()})
                                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    //.padding()
                                    HStack {
                                        Link("FAX:", destination: URL(string: "fax://"+userdata.fax)!)
                                        TextField("FAX", text: $userdata.fax, onCommit: {updateDb()})
                                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    //.padding()
                                    HStack {
                                        Link("E-mail:", destination: URL(string: "mailto:"+userdata.email)!)
                                        TextField("E-mail", text: $userdata.email, onCommit: {updateDb()})
                                            .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                    }
                                    //.padding()
                                    HStack {
                                        if userdata.homepage.count > 0 {
                                            Link("URL:", destination: URL(string: userdata.homepage)!)
                                        }else{
                                            Text("URL:")
                                                .font(.callout)
                                                .bold()
                                        }
                                        TextField("URL", text: $userdata.homepage, onCommit: {updateDb()})
                                                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                        }
                                        //.padding()
                                }//Group
                            }//VStack
                            if showingMapPopUp {
                                PopUpMapView(latitude: latitude, longitude: longitude, isPresent: $showingMapPopUp)
                            }
                        }//ZStack
                    }//Section
                    //広告ビュー
                    //AdView()
                    Section(header: Text("SNS情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        ZStack{
                            VStack {
                                HStack {
                                    Link("facebook:", destination: URL(string: AppSNSLink.link_facebook + userdata.facebook)!)

                                    TextField("facebook", text: $userdata.facebook, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Link("instagram:", destination: URL(string: AppSNSLink.link_instagram + userdata.instagram)!)
                                    TextField("instagram", text: $userdata.instagram, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Link("twitter:", destination: URL(string: AppSNSLink.link_twitter + userdata.twitter)!)
                                    TextField("twitter", text: $userdata.twitter, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    //Link("LINE:", destination: URL(string: AppSNSLink.link_line + userdata.line_id)!)
                                    Link("LINE:", destination: URL(string: AppSNSLink.link_line)!)
                                    TextField("LINE ID", text: $userdata.line_id, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Link("YouTube:", destination: URL(string: AppSNSLink.link_YouTube + userdata.youtube)!)
                                    TextField("YouTube", text: $userdata.youtube, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("SNS:")
                                        .font(.callout)
                                        .bold()
                                    TextField("SNS", text: $userdata.sns, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                            }//VStack
                        }//ZStack
                    }//Section
                    //広告ビュー
                    AdView()
                    Section(header: Text("名刺交換情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        ZStack{
                            VStack {
                                MapView(latitude: userdata.latitude,longitude: userdata.longitude)
                                        .edgesIgnoringSafeArea(.top)
                                        .frame(height: 200)

                                HStack {
                                    Text("名刺交換日:")
                                        .font(.callout)
                                        .bold()
                                    TextField("名刺交換日", text: $userdata.meeting_date_str, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("名刺交換場所:")
                                        .font(.callout)
                                        .bold()
                                    TextField("名刺交換場所", text: $userdata.meeting_place, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("名刺交換緯度:")
                                        .font(.callout)
                                        .bold()
                                    TextField("名刺交換緯度", text: $userdata.latitude, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                
                                }
                                //.padding()
                                HStack {
                                    Text("名刺交換経度:")
                                        .font(.callout)
                                        .bold()
                                    TextField("名刺交換経度", text: $userdata.longitude, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                
                                }
                                //.padding()
                            }//VStack
                        }//ZStack
                    }//Group
                    //広告ビュー
                    //AdView()
                    Section(header: Text("個人情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        ZStack{
                            VStack {
                                HStack {
                                    Text("姓:")
                                        .font(.callout)
                                        .bold()
                                    TextField("姓", text: $userdata.familyname, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("名:")
                                        .font(.callout)
                                        .bold()
                                    TextField("名", text: $userdata.givenname, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("ミドルネーム:")
                                        .font(.callout)
                                        .bold()
                                    TextField("ミドルネーム", text: $userdata.middlename, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("ハンドルネーム:")
                                        .font(.callout)
                                        .bold()
                                    TextField("ハンドルネーム", text: $userdata.handlename, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("誕生日:")
                                        .font(.callout)
                                        .bold()
                                    TextField("誕生日", text: $userdata.birth_date_str, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
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
                            }//VStack
                        }//ZStack
                    }//Section
                    //広告ビュー
                    //AdView()
                    Section(header: Text("その他情報").font(.system(size: 18.0)).foregroundColor(.gray)) {
                        ZStack{
                            VStack {
                                HStack {
                                    Text("任意1:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意1", text: $userdata.temp1, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("任意2:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意2", text: $userdata.temp2, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("任意3:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意3", text: $userdata.temp3, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("任意4:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意4", text: $userdata.temp4, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("任意5:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意5", text: $userdata.temp5, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("任意6:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意6", text: $userdata.temp6, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                /*//性別
                                HStack {
                                    Text("任意7:")
                                        .font(.callout)
                                        .bold()
                                    TextField("任意7", text: $userdata.temp7, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                                //.padding()
                                HStack {
                                    Text("会社ロゴファイル名:")
                                        .font(.callout)
                                        .bold()
                                    TextField("会社ロゴファイル名", text: $userdata.logoImageName, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }*/
                                //.padding()
                                HStack {
                                    Text("顔写真ファイル名:")
                                        .font(.callout)
                                        .bold()
                                    TextField("顔写真ファイル名", text: $userdata.profileImageName, onCommit: {updateDb()})
                                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                                }
                            }//VStack
                        }//ZStack
                    }//Section

                    HStack {
                        Spacer()
                        //削除
                        if userdata.id > 1 {
                            VStack{
                                Image("delete")
                                    .onLongPressGesture {
                                        DB_Manager().deleteUser(idValue: userdata.id)
                                        // go back to home page
                                        self.mode.wrappedValue.dismiss()
                                        print("delete")
                                    }
                                Text("長押し")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }
                            /*
                            NavigationLink(destination: EmptyView()) {
                                Button(action: {
                                    DB_Manager().deleteUser(idValue: userdata.id)
                                    // go back to home page
                                    self.mode.wrappedValue.dismiss()
                                    print("delete")
                                }) {
                                    CircleImage(image: Image("delete"))
                                }
                            }*/
                        }
                        /*
                        //保存
                        NavigationLink(destination: EmptyView()) {
                            Button(action: {
                                DB_Manager().updateUser(idValue: userdata.id, categoryValue:userdata.category, fullnameValue:userdata.fullname, fullyomiValue:userdata.fullyomi, company1Value:userdata.company1, company1yomiValue:userdata.company1yomi, company2Value:userdata.company2, departmentValue:userdata.department, sectionValue:userdata.section, roleValue:userdata.role, zipcodeValue:userdata.zipcode, address1Value:userdata.address1, address2Value:userdata.address2, telValue:userdata.tel, faxValue:userdata.fax, emailValue: userdata.email, homepageValue:userdata.homepage, facebookValue:userdata.facebook, twitterValue:userdata.twitter, instagramValue:userdata.instagram, line_idValue:userdata.line_id, youtubeValue:userdata.youtube, snsValue:userdata.sns, meeting_date_strValue:userdata.meeting_date_str, meeting_placeValue:userdata.meeting_place, latitudeValue:userdata.latitude, longitudeValue:userdata.longitude, birth_date_strValue:userdata.birth_date_str, familynameValue:userdata.familyname, givennameValue:userdata.givenname, middlenameValue:userdata.middlename, handlenameValue:userdata.handlename, temp1Value:userdata.temp1, temp2Value:userdata.temp2, temp3Value:userdata.temp3, temp4Value:userdata.temp4, temp5Value:userdata.temp5, temp6Value:userdata.temp6, temp7Value:userdata.temp7, logoImageNameValue:userdata.logoImageName, profileImageNameValue:userdata.profileImageName)
             
                                // go back to home page
                                self.mode.wrappedValue.dismiss()
                                print("save")
                            }) {
                                CircleImage(image: Image("save"))
                            }
                        }*/
                    }


                }//Section
                .padding()
            }//VStack
        }//ScrollView
        .onAppear(perform: {
            //self.userdata = self.person
            self.categoryModels = DB_ManagerCategory().getCategories()
            var i = 0
            self.selection = i
            for category in self.categoryModels {
            //ForEach(self.categoryModels) { category in {
                self.options.append(category.category)
                if userdata.category == category.category {
                    self.selection = i
                }
                i = i + 1
            }
            userdata_category = userdata.category
            if userdata.temp7 == "男性" {
                self.sexIndex = 0
            }else if userdata.temp7 == "女性" {
                self.sexIndex = 1
            }else{
                self.sexIndex = 2
            }
        })
        .navigationBarTitle("名刺交換データ")
    }//body

    func updateDb() {
        DB_Manager().updateUser(idValue: userdata.id, categoryValue:userdata.category, fullnameValue:userdata.fullname, fullyomiValue:userdata.fullyomi, company1Value:userdata.company1, company1yomiValue:userdata.company1yomi, company2Value:userdata.company2, departmentValue:userdata.department, sectionValue:userdata.section, roleValue:userdata.role, zipcodeValue:userdata.zipcode, address1Value:userdata.address1, address2Value:userdata.address2, telValue:userdata.tel, faxValue:userdata.fax, emailValue: userdata.email, homepageValue:userdata.homepage, facebookValue:userdata.facebook, twitterValue:userdata.twitter, instagramValue:userdata.instagram, line_idValue:userdata.line_id, youtubeValue:userdata.youtube, snsValue:userdata.sns, meeting_date_strValue:userdata.meeting_date_str, meeting_placeValue:userdata.meeting_place, latitudeValue:userdata.latitude, longitudeValue:userdata.longitude, birth_date_strValue:userdata.birth_date_str, familynameValue:userdata.familyname, givennameValue:userdata.givenname, middlenameValue:userdata.middlename, handlenameValue:userdata.handlename, temp1Value:userdata.temp1, temp2Value:userdata.temp2, temp3Value:userdata.temp3, temp4Value:userdata.temp4, temp5Value:userdata.temp5, temp6Value:userdata.temp6, temp7Value:userdata.temp7, logoImageNameValue:userdata.logoImageName, profileImageNameValue:userdata.profileImageName)
        print("save")
        userdata = DB_Manager().getUser(idValue: Int64(userdata.id))
    }
    
    func setCategory(category:String) {
        userdata.category = category
        print("category : \(userdata.category)")
        updateDb()
    }

    func sexChange(_ tag: Int) {
        userdata.temp7 = sexItem[tag]
        if userdata.profileImageName.count == 0 {
            if userdata.temp7 == "男性" {
                userdata.profileImageName = "avatar"
            }else if userdata.temp7 == "女性" {
                userdata.profileImageName = "avatar_f"
            }
        }
        updateDb()
        print("sex : \(tag) \(userdata.temp7)")
    }
}


/*
struct UserDataDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDataDetail(person: UserModel)
    }
}
*/
