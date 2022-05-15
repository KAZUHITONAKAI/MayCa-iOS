import SwiftUI
import MapKit // import CoreLocation でも可


struct QRCode2UserDetail: View {
    var scanedString:String
    @Binding var isPresent: Bool
    //var person: UserModel
    @State var userdata:UserModel = UserModel()
    //@Binding var userdata:UserModel = UserModel()
    @State var isMaycaData:Bool = false
    
    @State var last_key:String = ""
    @State var last_val:String = ""

    // to go back to previous view
    //@Environment(\.presentationMode) var mode: Binding<PresentationMode>

    var body: some View {
        VStack(alignment: .center){
            if isMaycaData == true {
                //UserDataDetail(person: userdata)
                BusinessCardView(person: $userdata)
            }else{
                //広告ビュー
                AdView()
                Text("読み込んだQRデータ")
                    .font(.system(size: 22))
                    .foregroundColor(.blue)
                Divider()
                Text(scanedString).font(.system(size: 12))
                    .contextMenu{
                        Button(action: {
                            UIApplication.shared.open(URL(string: scanedString)!)
                        }){
                            Label("開く", systemImage:"safari")
                        }
                        Button(action: {
                            UIPasteboard.general.string = scanedString
                        }){
                            Label("コピー", systemImage:"doc.on.doc")
                        }
                    }
                Divider()
            }
        /*
        ScrollView{
            VStack(alignment: .center){
                if isMaycaData == true {
                    BusinessCardView(person: $userdata)
                    .padding()

                    //10個以上の場合は、Groupを使う事で解消しました。
                    Group{
                        Section(header: Text("会社情報").font(.system(size: 14.0))) {
                            
                            HStack {
                                Text("カテゴリ:")
                                   .font(.callout)
                                   .bold()
                                TextField("カテゴリ", text: $userdata.category).environment(\.isEnabled, true)
                                   .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("氏名:")
                                    .font(.callout)
                                    .bold()
                                    TextField("氏名", text: $userdata.fullname)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("フリガナ:")
                                    .font(.callout)
                                    .bold()
                                    TextField("フリガナ", text: $userdata.fullyomi)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("会社名1:")
                                    .font(.callout)
                                    .bold()
                                    TextField("会社名1", text: $userdata.company1)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("フリガナ:")
                                    .font(.callout)
                                    .bold()
                                    TextField("フリガナ", text: $userdata.company1yomi)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("会社名2:")
                                    .font(.callout)
                                    .bold()
                                    TextField("会社名2", text: $userdata.company2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("所属部署（部）:")
                                    .font(.callout)
                                    .bold()
                                    TextField("所属部署（部）", text: $userdata.department)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("所属部署（課）:")
                                    .font(.callout)
                                    .bold()
                                    TextField("所属部署（課）", text: $userdata.section)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("役職:")
                                    .font(.callout)
                                    .bold()
                                    TextField("役職", text: $userdata.role)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                        }//Group
                        Group{
                            HStack {
                                    Text("郵便番号:")
                                    .font(.callout)
                                    .bold()
                                    TextField("郵便番号", text: $userdata.zipcode)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("住所1:")
                                    .font(.callout)
                                    .bold()
                                    TextField("住所1", text: $userdata.address1)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("住所2:")
                                    .font(.callout)
                                    .bold()
                                    TextField("住所2", text: $userdata.address2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("TEL:")
                                    .font(.callout)
                                    .bold()
                                TextField("TEL", text: $userdata.tel)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("Mobile Phone:")
                                    .font(.callout)
                                    .bold()
                                TextField("Mobile Phone", text: $userdata.temp6)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("FAX:")
                                    .font(.callout)
                                    .bold()
                                TextField("FAX", text: $userdata.fax)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("E-mail:")
                                    .font(.callout)
                                    .bold()
                                TextField("E-mail", text: $userdata.email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("URL:")
                                    .font(.callout)
                                    .bold()
                                TextField("URL", text: $userdata.homepage)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                        }//Group
                            Section(header: Text("SNS情報").font(.system(size: 14.0))) {
                            HStack {
                                Text("facebook:")
                                    .font(.callout)
                                    .bold()
                                TextField("facebook", text: $userdata.facebook)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("instagram:")
                                    .font(.callout)
                                    .bold()
                                TextField("instagram", text: $userdata.instagram)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("twitter:")
                                    .font(.callout)
                                    .bold()
                                TextField("twitter", text: $userdata.twitter)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("LINE:")
                                    .font(.callout)
                                    .bold()
                                TextField("LINE ID", text: $userdata.line_id)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("YouTube:")
                                    .font(.callout)
                                    .bold()
                                TextField("YouTube", text: $userdata.youtube)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("SNS:")
                                    .font(.callout)
                                    .bold()
                                TextField("SNS", text: $userdata.sns)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            }//Group
                            Section(header: Text("名刺交換情報").font(.system(size: 14.0))) {
                                MapView(latitude: userdata.latitude,longitude: userdata.longitude)
                                    .edgesIgnoringSafeArea(.top)
                                    .frame(height: 200)

                            HStack {
                                    Text("名刺交換日:")
                                    .font(.callout)
                                    .bold()
                                    TextField("名刺交換日", text: $userdata.meeting_date_str)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("名刺交換場所:")
                                    .font(.callout)
                                    .bold()
                                    TextField("名刺交換場所", text: $userdata.meeting_place)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("名刺交換緯度:")
                                    .font(.callout)
                                    .bold()
                                    TextField("名刺交換緯度", text: $userdata.latitude)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
            
                            }
                            //.padding()
                            HStack {
                                    Text("名刺交換経度:")
                                    .font(.callout)
                                    .bold()
                                    TextField("名刺交換経度", text: $userdata.longitude)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
            
                            }
                            //.padding()
                            }//Group
                            Section(header: Text("個人情報").font(.system(size: 14.0))) {
                            HStack {
                                    Text("姓:")
                                    .font(.callout)
                                    .bold()
                                    TextField("姓", text: $userdata.familyname)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("名:")
                                    .font(.callout)
                                    .bold()
                                    TextField("名", text: $userdata.givenname)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("ミドルネーム:")
                                    .font(.callout)
                                    .bold()
                                    TextField("ミドルネーム", text: $userdata.middlename)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("ハンドルネーム:")
                                    .font(.callout)
                                    .bold()
                                    TextField("ハンドルネーム", text: $userdata.handlename)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("誕生日:")
                                    .font(.callout)
                                    .bold()
                                    TextField("誕生日", text: $userdata.birth_date_str)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("任意1:")
                                    .font(.callout)
                                    .bold()
                                    TextField("任意1", text: $userdata.temp1)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("任意2:")
                                    .font(.callout)
                                    .bold()
                                    TextField("任意2", text: $userdata.temp2)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                    Text("任意3:")
                                    .font(.callout)
                                    .bold()
                                    TextField("任意3", text: $userdata.temp3)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                       }//Group
                        Group{
                            //.padding()
                            HStack {
                                Text("任意4:")
                                    .font(.callout)
                                    .bold()
                                TextField("任意4", text: $userdata.temp4)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("任意5:")
                                    .font(.callout)
                                    .bold()
                                TextField("任意5", text: $userdata.temp5)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("任意7:")
                                    .font(.callout)
                                    .bold()
                                TextField("任意7", text: $userdata.temp7)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("会社ロゴファイル名:")
                                    .font(.callout)
                                    .bold()
                                TextField("会社ロゴファイル名", text: $userdata.logoImageName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("顔写真ファイル名:")
                                    .font(.callout)
                                    .bold()
                                TextField("顔写真ファイル名", text: $userdata.profileImageName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                        }//Group

                    }//Section
                    .padding()
                }else{
                    //広告ビュー
                    AdView()
                    Text("読み込んだQRデータ")
                        .font(.system(size: 22))
                        .foregroundColor(.blue)
                    Divider()
                    //Label(scanedString, systemImage: "qrcode.viewfinder")
                    Text(scanedString).font(.system(size: 12))
                        .contextMenu{
                            Button(action: {
                                UIApplication.shared.open(URL(string: scanedString)!)
                            }){
                                Label("開く", systemImage:"safari")
                            }
                            Button(action: {
                                UIPasteboard.general.string = scanedString
                            }){
                                Label("コピー", systemImage:"doc.on.doc")
                            }
                        }
                    Divider()
                }
            }//VStack
        }//ScrollView
 */
    }//VStack
        .onAppear(perform: {
            isMaycaData = false
            userdata.profileImageName = "avatar"
            if current_qr_status == 0 {
                isPresent = true
            }else{
                isPresent = false
            }
            print("isPreasen \(isPresent)")
            let usrString:String = scanedString
            let teststr = usrString.components(separatedBy: ",")
            print(teststr)
            for i in 0..<teststr.count {
                let elem = teststr[i].components(separatedBy: "=")
                if elem.count == 2 {
                    print(elem[0])
                    print(elem[1])
                }
            }

            for i in 0..<teststr.count {
                let elem = teststr[i].components(separatedBy: "=")
                if elem.count == 2 {
                    print(elem[0])
                    print(elem[1])
                    self.last_key = elem[0]
                    self.last_val = elem[1]
                    setKeyValueFromQRString(userdata: userdata, keystr: elem[0], valstr: elem[1])
                }else if elem.count == 1 {
                    if elem[0].count > 0 {
                        setKeyValueFromQRString(userdata: userdata, keystr: self.last_key, valstr: self.last_val+","+elem[0])
                    }
                }
            }
            //userdata = DB_Manager().getUser(idValue: g_index)
            userdata.latitude = String(location.latitude)
            userdata.longitude = String(location.longitude)
            //緯度経度から住所取得
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
                guard placemark.locality != nil else{
                    return
                }
                locality = placemark.locality!
                guard placemark.name != nil else{
                    return
                }
                local_name = placemark.name!

                userdata.meeting_place = locality + local_name
            }
            
            //現在の日付
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.timeStyle = .none
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let nowdate = Date()
            print(nowdate)
            let datestr = dateFormatter.string(from: nowdate)
            print(datestr)
            userdata.meeting_date_str = datestr

            if isMaycaData==true {
                DB_Manager().addUser(categoryValue:userdata.category, fullnameValue:userdata.fullname, fullyomiValue:userdata.fullyomi, company1Value:userdata.company1, company1yomiValue:userdata.company1yomi, company2Value:userdata.company2, departmentValue:userdata.department, sectionValue:userdata.section, roleValue:userdata.role, zipcodeValue:userdata.zipcode, address1Value:userdata.address1, address2Value:userdata.address2, telValue:userdata.tel, faxValue:userdata.fax, emailValue: userdata.email, homepageValue:userdata.homepage, facebookValue:userdata.facebook, twitterValue:userdata.twitter, instagramValue:userdata.instagram, line_idValue:userdata.line_id, youtubeValue:userdata.youtube, snsValue:userdata.sns, meeting_date_strValue:userdata.meeting_date_str, meeting_placeValue:userdata.meeting_place, latitudeValue:userdata.latitude, longitudeValue:userdata.longitude, birth_date_strValue:userdata.birth_date_str, familynameValue:userdata.familyname, givennameValue:userdata.givenname, middlenameValue:userdata.middlename, handlenameValue:userdata.handlename, temp1Value:userdata.temp1, temp2Value:userdata.temp2, temp3Value:userdata.temp3, temp4Value:userdata.temp4, temp5Value:userdata.temp5, temp6Value:userdata.temp6, temp7Value:userdata.temp7, logoImageNameValue:userdata.logoImageName, profileImageNameValue:userdata.profileImageName)
            }
        })
        .navigationBarTitle("名刺交換完了")
    }//body
    
    func getPlaceName() -> String {
        return "横浜市金沢区"
    }
    
    func setKeyValueFromQRString(userdata:UserModel, keystr:String, valstr:String) -> UserModel {
        print(keystr)
        print(valstr)
        self.last_key = keystr
        self.last_val = valstr
        switch keystr {
        case "'category'":
            userdata.category = valstr
        case "'fullname'":
            userdata.fullname = valstr
            isMaycaData = true
        case "'fullyomi'":
            userdata.fullyomi = valstr
        case "'company1'":
            userdata.company1 = valstr
            isMaycaData = true
        case "'company2'":
            userdata.company2 = valstr
        case "'department'":
            userdata.department = valstr
        case "'section'":
            userdata.section = valstr
        case "'role'":
            userdata.role = valstr
        case "'zipcode'":
            userdata.zipcode = valstr
        case "'address1'":
            userdata.address1 = valstr
        case "'address2'":
            userdata.address2 = valstr
        case "'tel'":
            userdata.tel = valstr
        case "'fax'":
            userdata.fax = valstr
        case "'email'":
            userdata.email = valstr
        case "'homepage'":
            userdata.homepage = valstr
        case "'facebook'":
            userdata.facebook = valstr
        case "'twitter'":
            userdata.twitter = valstr
        case "'instagram'":
            userdata.instagram = valstr
        case "'line_id'":
            userdata.line_id = valstr
        case "'youtube'":
            userdata.youtube = valstr
        case "'sns'":
            userdata.sns = valstr
        /*
        case "'meeting_date_str'":
            userdata.meeting_date_str = valstr
        case "'meeting_place'":
            userdata.meeting_place = valstr
        case "'latitude'":
            userdata.latitude = valstr
        case "'longitude'":
            userdata.longitude = valstr
        */
        case "'birth_date_str'":
            userdata.birth_date_str = valstr
        case "'familyname'":
            userdata.familyname = valstr
        case "'givenname'":
            userdata.givenname = valstr
        case "'middlename'":
            userdata.middlename = valstr
        case "'handlename'":
            userdata.handlename = valstr
        case "'temp1'":
            userdata.temp1 = valstr
        case "'temp2'":
            userdata.temp2 = valstr
        case "'temp3'":
            userdata.temp3 = valstr
        case "'temp4'":
            userdata.temp4 = valstr
        case "'temp5'":
            userdata.temp5 = valstr
        case "'temp6'":
            userdata.temp6 = valstr
        case "'temp7'":
            userdata.temp7 = valstr
        case "'logoImageName'":
            userdata.logoImageName = valstr
        case "'profileImageName'":
            if valstr.count == 0 {
                if userdata.temp7 == "男性" {
                    userdata.profileImageName = "avatar"
                }else if userdata.temp7 == "女性" {
                    userdata.profileImageName = "avatar_f"
                }else{
                    userdata.profileImageName = ""
                }
            }else{
                userdata.profileImageName = valstr
            }
        default:
            userdata.temp7 = valstr
        }
        return userdata;
    }
}
/*
struct UserDataDetail_Previews: PreviewProvider {
    static var previews: some View {
        UserDataDetail(person: UserModel)
    }
}
*/
