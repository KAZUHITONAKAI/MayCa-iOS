//
//  BusinessCardView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/19.
//

import SwiftUI
import Photos

struct BusinessCardView: View {
    @Binding var person: UserModel// = DB_Manager().getUser(idValue: Int64(g_index))
    var text_width_out:CGFloat = screen_info.width*0.9
    var text_width_in:CGFloat = screen_info.width*0.86
    @State var isActiveProfile = true
    @State var logo_image:UIImage?
    @State var profile_image:UIImage?
    @State var image_str:String = ""
    @State var position_logo: CGSize = CGSize(width: 50, height: 50)
    @State var position_profile: CGSize = CGSize(width: 50, height: 50)
    @GestureState private var dragState = DragState.inactive
    @GestureState private var dragState2 = DragState.inactive
    @State var latitude: String = ""
    @State var longitude: String = ""

    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
     
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
     
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    
    var body: some View {
        //名刺イメージ
        VStack(alignment: .center) {
            //Section(header: Text("名刺イメージ").font(.system(size: 18))) {
            //}//Section
            //広告ビュー
            AdView()
            //Text("x: \(position.width)    y: \(position.height)").font(.system(size: 10))
            //Text("名刺イメージ")
            //    .font(.system(size: 18))
            //    .frame(width: self.text_width_in, alignment: .center)
            ZStack{
                //名刺枠
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.white)
                    //.fill(Image("businesscard_background").resizable().scaledToFill().opacity(0.9))
                    .frame(width: self.text_width_out, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .shadow(color: .gray, radius: 2, x:2, y:2  )
                    .padding()
                    if logo_image != nil && person.id == 1 {
                        Image(uiImage: logo_image!)
                            .resizable()
                            .scaledToFit()
                            //.scaledToFill()
                            .frame(width: 80)
                            //.offset(x:100, y: -70)
                            .offset(x: position_logo.width + dragState.translation.width, y: position_logo.height + dragState.translation.height)
                            .gesture(
                                LongPressGesture(minimumDuration: 1.0)
                                .sequenced(before: DragGesture())
                                .updating($dragState, body: { (value, state, transaction) in
                    
                                    switch value {
                                    case .first(true):
                                        state = .pressing
                                    case .second(true, let drag):
                                        state = .dragging(translation: drag?.translation ?? .zero)
                                        if drag != nil {
                                            self.position_logo.height = drag!.translation.height
                                            self.position_logo.width = drag!.translation.width
                                        }
                                    default:
                                        break
                                    }

                                })
                                .onEnded({ (value) in
                    
                                    guard case .second(true, let drag?) = value else {
                                        return
                                    }
                    
                                    self.position_logo.height += drag.translation.height
                                    self.position_logo.width += drag.translation.width
                                    UserDefaults.standard.set(self.position_logo.width, forKey: "pos_w")
                                    UserDefaults.standard.set(self.position_logo.height, forKey: "pos_h")
                                })
                            )
                    }

                //名刺本体
                VStack(alignment: .leading) {
                    Spacer()
                    //Divider()
                    Group{
                        Text(person.company1)
                            .font(.system(size: 18))
                            .foregroundColor(.black)
                            .frame(width: self.text_width_in, alignment: .leading)
                            
                        Text(person.company2)
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                            .frame(width: self.text_width_in, alignment: .leading)
                        HStack{
                            Text(person.department)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            //.frame(width: self.text_width_in, alignment: .leading)
                            //Spacer()
                            Text(person.section)
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            //.frame(width: self.text_width_in, alignment: .leading)
                        }
                        HStack {
                            Text(" ")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                            Text(person.role)
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                        }
                        .frame(width: self.text_width_in, alignment: .leading)
                        HStack {
                            Text("     ")
                                .font(.system(size: 13))
                                .foregroundColor(.black)
                            Text(person.fullname)
                                .font(.system(size: 22, design: .rounded))
                                .foregroundColor(.black)
                                .contextMenu{
                                    Button(action: {
                                        UIPasteboard.general.string = person.fullname
                                    }){
                                        Label("コピー", systemImage:"doc.on.doc")
                                    }
                                }
                        }
                        .frame(width: self.text_width_in, alignment: .leading)
                    }
                    Group{
                        HStack{
                            if person.zipcode.count > 0 {
                                Text("〒")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                            }
                            Text(person.zipcode)
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                            //Spacer()
                        }
                        .frame(width: self.text_width_in, alignment: .leading)
                        HStack{
                            Text(person.address1)
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .contextMenu{
                                    Button(action: {
                                        
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
                                            UIApplication.shared.open(URL(string: AppSNSLink.link_maps+"\(self.latitude),\(self.longitude)&t=m")!)
                                            //print(AppSNSLink.link_maps+"\(self.latitude),\(self.longitude)")
                                        }
                                    }){
                                        Label("開く", systemImage:"mappin.and.ellipse")
                                    }
                                    Button(action: {
                                        UIPasteboard.general.string = person.address1
                                    }){
                                        Label("コピー", systemImage:"doc.on.doc")
                                    }
                                }
                            Text(person.address2)
                                .font(.system(size: 12))
                                .foregroundColor(.black)
                                .contextMenu{
                                    Button(action: {
                                        let address = person.address2
                                        CLGeocoder().geocodeAddressString(address) { placemarks, error in
                                            if let lat = placemarks?.first?.location?.coordinate.latitude {
                                                print("緯度 : \(lat)")
                                                self.latitude = String(lat)
                                            }
                                            if let lng = placemarks?.first?.location?.coordinate.longitude {
                                                print("経度 : \(lng)")
                                                self.longitude = String(lng)
                                            }
                                            UIApplication.shared.open(URL(string: AppSNSLink.link_maps+"\(self.latitude),\(self.longitude)&t=m")!)
                                        }
                                    }){
                                        Label("開く", systemImage:"mappin.and.ellipse")
                                    }
                                    Button(action: {
                                        UIPasteboard.general.string = person.address2
                                    }){
                                        Label("コピー", systemImage:"doc.on.doc")
                                    }
                                }
                        }
                        .frame(width: self.text_width_in, alignment: .leading)

                        HStack{
                            if person.email.count > 0 {
                                Text("e-mail:")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                Text(person.email)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        Button(action: {
                                            UIApplication.shared.open(URL(string:  AppSNSLink.link_email+person.email)!)
                                        }){
                                            Label("メールする", systemImage:"envelope")
                                        }
                                        Button(action: {
                                            UIPasteboard.general.string = person.email
                                        }){
                                            Label("コピー", systemImage:"doc.on.doc")
                                        }                                    }
                            }
                        }
                        .frame(width: self.text_width_in, alignment: .leading)
                        HStack{
                            if person.tel.count > 0 {
                                Text("Tel:")
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                                Text(person.tel)
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        Button(action: {
                                            UIApplication.shared.open(URL(string: AppSNSLink.link_tel+person.tel)!)
                                        }){
                                            Label("電話する", systemImage:"phone.arrow.up.right")
                                        }
                                        Button(action: {
                                            UIPasteboard.general.string = person.tel
                                        }){
                                            Label("コピー", systemImage:"doc.on.doc")
                                        }                                    }
                            }
                            if person.temp6.count > 0 {
                                Text(" Mobile:")
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                                Text(person.temp6)
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        Button(action: {
                                            UIApplication.shared.open(URL(string: AppSNSLink.link_tel+person.temp6)!)
                                        }){
                                            Label("電話する", systemImage:"phone.arrow.up.right")
                                        }
                                        Button(action: {
                                            UIPasteboard.general.string = person.homepage
                                        }){
                                            Label("コピー", systemImage:"doc.on.doc")
                                        }                                    }
                            }
                            if person.fax.count > 0 {
                                Text(" fax:")
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                                Text(person.fax)
                                    .font(.system(size: 11))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: self.text_width_in, alignment: .leading)
                        HStack{
                            if person.homepage.count > 0 {
                                Text("URL:")
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                Text(person.homepage)
                                    .font(.system(size: 12))
                                    .foregroundColor(.black)
                                    .contextMenu{
                                        Button(action: {
                                            UIApplication.shared.open(URL(string: person.homepage)!)
                                        }){
                                            Label("開く", systemImage:"safari")
                                        }
                                        Button(action: {
                                            UIPasteboard.general.string = person.homepage
                                        }){
                                            Label("コピー", systemImage:"doc.on.doc")
                                        }                                    }
                            }
                        }
                        .frame(width: self.text_width_in, alignment: .leading)
                    }
                    //Divider()
                    Spacer()
                }
                .frame(width: self.text_width_out)

                /*
                Button(action: {
                    self.isActiveProfile.toggle()
                    image_str = UserDefaults.standard.string(forKey: "avater") ?? "avater"
                    print("path:\(image_str)")
                    profile_image = loadImageFromPath(path: image_str)
                }) {
                    if self.isActiveProfile {
                        if image_str.count>0 {
                            //CircleImage(image: Image(uiImage: profile_image!))
                            if profile_image != nil && person.id == 1 {
                                Image(uiImage: profile_image!)
                                    .resizable()
                                    .scaledToFit()
                                    //.scaledToFill()
                                    .frame(width: 60)
                            }
                        }
                   }else{
                        Text("画像").font(.system(size: 10))
                    }
                }
                 .offset(x:100, y: -5)
                 */
                 if profile_image != nil && person.id == 1 {
                     Image(uiImage: profile_image!)
                        .resizable()
                        .scaledToFit()
                        //.scaledToFill()
                        .frame(width: 60)
                        .offset(x:100, y: 10)
                        .offset(x: position_profile.width + dragState2.translation.width, y: position_profile.height + dragState2.translation.height)
                        .gesture(
                            LongPressGesture(minimumDuration: 1.0)
                            .sequenced(before: DragGesture())
                            .updating($dragState2, body: { (value, state, transaction) in
                
                                switch value {
                                case .first(true):
                                    state = .pressing
                                case .second(true, let drag):
                                    state = .dragging(translation: drag?.translation ?? .zero)
                                    if drag != nil {
                                        self.position_profile.height = drag!.translation.height
                                        self.position_profile.width = drag!.translation.width
                                    }
                                default:
                                    break
                                }

                            })
                            .onEnded({ (value) in
                
                                guard case .second(true, let drag?) = value else {
                                    return
                                }
                
                                self.position_profile.height += drag.translation.height
                                self.position_profile.width += drag.translation.width
                                UserDefaults.standard.set(self.position_profile.width, forKey: "pos2_w")
                                UserDefaults.standard.set(self.position_profile.height, forKey: "pos2_h")
                            })
                        )
                 }
                //CircleImage(image: Image(person.profileImageName))
                //    .offset(x:120, y: 55)
            }//ZStack
        }//VStack
        .frame(width: screen_info.width, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        .onAppear(perform: {
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

            self.position_logo.width = CGFloat(UserDefaults.standard.float(forKey: "pos_w"))
            self.position_logo.height = CGFloat(UserDefaults.standard.float(forKey: "pos_h"))
            self.position_profile.width = CGFloat(UserDefaults.standard.float(forKey: "pos2_w"))
            self.position_profile.height = CGFloat(UserDefaults.standard.float(forKey: "pos2_h"))
        })
    }
}

/*
struct BusinessCardView_Previews: PreviewProvider {
    @State var person: UserModel = DB_Manager().getUser(idValue: g_index)
    static var previews: some View {
        BusinessCardView(person: $person)
    }
}
*/
