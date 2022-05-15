//
//  ContentView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/04/19.
//

import SwiftUI

var g_index:Int64 = 1
var current_qr_status = 0


struct ContentView: View {
    //var person: PersonData = personData[0]
    @State var person: UserModel = DB_Manager().getUser(idValue: g_index)

    // array of user models
    //@EnvironmentObject var model:Model
    @State var isActiveBCExchangeView = false
    @State var isActiveImagePickerView = false
    @State var isActiveMyDataView = false
    @State var isActivePersonDataView = false
    @State var isActiveMayCaShopView = false
    @State var isActiveMeetingLayoutView = false
    @State var isActiveMyDataSettingView = false
    @State var isActiveReserve1View = false
    @State var isActiveReserve2View = false
    @State var isActiveReserve3View = false
    @State var isActiveMaintenanceView = false
    @State var isActiveMayCaDocumentView = false

    @State private var isEnableSendData = false
    @State private var isEnableSendApp = false

    @State var showingQrPopUp = false
    @State var showingCameraPopUp = false
    @State var showShareSheet = false
    

    @State private var qr_image: UIImage?
    @State var QrCodeString:String = ""
    @State var isPresent = false
    @State var profile_image:UIImage?
    @State var image_str:String = ""
    var btn_width_out:CGFloat = screen_info.width*0.7
    var btn_height:CGFloat = 18
    var btn_radius:CGFloat = 10.0
    var shadow_color:Color = Color.gray

    var body: some View {

        NavigationView {
            ZStack{
                VStack(alignment: .center){
                    BusinessCardView(person: $person)
                    .padding()
                    //HStack{
                    /*
                    Form {
                        HStack{
                            NavigationLink(
                                destination:EmptyView()
                            ) {
                                Button(action: {
                                    withAnimation {
                                        showingCameraPopUp = true
                                    }
                                }) {
                                    Text("MyCa QRコード読み込み")
                                        .frame(width: btn_width_out, height: btn_height, alignment: .center)
                                }
                            }
                            Spacer()
                        }//
                        HStack{
                            NavigationLink(
                                destination:MyDataView(person: self.$person),
                                isActive:$isActiveMyDataView
                            ) {
                                Button(action: {
                                    //self.isActiveCategoryView.toggle()
                                }) {
                                    Text("マイデータ表示")
                                }
                            }
                            Spacer()
                        }//
                        HStack{
                            NavigationLink(
                                destination:UserDataList(),
                                isActive:$isActivePersonDataView
                            ) {
                                Button(action: {
                                    self.isActivePersonDataView.toggle()
                                }) {
                                    Text("連絡先")
                                }
                            }
                            Spacer()
                        }//
                        HStack{
                            NavigationLink(
                                destination:EmptyView()
                            ) {
                                //MayCa共有
                                Button(action: {
                                    self.showShareSheet.toggle()
                                    print("")
                                }) {
                                    Text("MayCaアプリの共有")
                                        .frame(width: btn_width_out, height: btn_height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }.sheet(isPresented: self.$showShareSheet) {
                                    ShareMayCaSheet(url: AppSNSLink.link_mayca)
                                }
                            }
                            Spacer()
                        }//
                        HStack{
                            NavigationLink(
                                destination:EmptyView()
                            ) {
                                //MayCaアップデート
                                Button(action: {
                                    UIApplication.shared.open(URL(string: AppSNSLink.link_mayca)!)
                                    print("")
                                }) {
                                    Text("MayCaアップデート")
                                        .frame(width: btn_width_out, height: btn_height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                }
                            }
                            Spacer()
                        }//
                    }
                    */
                    ScrollView(.vertical, showsIndicators: true){
                        Group{
                            //QRコード読み込み
                            Button(action: {
                                withAnimation {
                                    showingCameraPopUp = true
                                }
                                print("")
                            }) {
                                Text("MyCa QRコード読み込み")
                                    .frame(width: btn_width_out, height: btn_height, alignment: .center)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(btn_radius)
                            .shadow(color: shadow_color, radius: 2, x:0, y:2  )
                            
                            //マイデータ
                            Button(action: {
                                self.isActiveMyDataView.toggle()
                                print("")
                            }) {
                                Text("MY DATA表示")
                                    .frame(width: btn_width_out, height: btn_height, alignment: .center)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(btn_radius)
                            .shadow(color: shadow_color, radius: 2, x:0, y:2  )
                            
                            //連絡先
                            Button(action: {
                                self.isActivePersonDataView.toggle()
                                print("")
                            }) {
                                Text("連絡帳")
                                    .frame(width: btn_width_out, height: btn_height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(btn_radius)
                            .shadow(color: shadow_color, radius: 2, x:0, y:2  )
                            
                            //MayCa共有
                            Button(action: {
                                self.showShareSheet.toggle()
                                print("")
                            }) {
                                Text("MayCaアプリを紹介する")
                                    .frame(width: btn_width_out, height: btn_height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }.sheet(isPresented: self.$showShareSheet) {
                                ShareMayCaSheet(url: AppSNSLink.link_mayca)
                            }.padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(btn_radius)
                            .shadow(color: shadow_color, radius: 2, x:0, y:2  )

                            //MayCaアップデート
                            Button(action: {
                                UIApplication.shared.open(URL(string: AppSNSLink.link_mayca)!)
                                print("")
                            }) {
                                Text("アプリUPLOAD確認")
                                    .frame(width: btn_width_out, height: btn_height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(btn_radius)
                            .shadow(color: shadow_color, radius: 2, x:0, y:2  )
                        }

                        Divider()
                        Spacer()
                        HStack {
                            //facebook
                            Button(action: {
                                print("")
                            }) {
                                Link(destination: URL(string: AppSNSLink.link_facebook + AppSNSLink.link_mayca_profile)!) {
                                    Image("facebook")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            Spacer()

                            //twitter
                            Button(action: {
                                print("")
                            }) {
                                Link(destination: URL(string: AppSNSLink.link_twitter + AppSNSLink.link_mayca_news)!) {
                                    Image("twitter")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                            }
                            Spacer()

                            //Instagram
                            Button(action: {
                                print("")
                            }) {
                                Link(destination: URL(string: AppSNSLink.link_instagram + AppSNSLink.link_mayca_news)!) {
                                    Image("instagram")
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }//HStack
                        .frame(width: screen_info.width*0.8, alignment: .leading)
                        Spacer()
                        /*
                        if profile_image != nil {
                            Image(uiImage: profile_image!)
                                .resizable()
                                //.scaledToFit()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                        }*/
                        //広告ビュー
                        AdView()
/*
                        if let uiImage = profile_image {
                            Image(uiImage: uiImage)
                                .resizable()
                                //.scaledToFit()
                                .scaledToFill()
                                .frame(width: 120, height: 120)
                            
                        } else {
                            Button(action: {
                                image_str = UserDefaults.standard.string(forKey: "avater") ?? "avater"
                                print("path:\(image_str)")
                                profile_image = loadImageFromPath(path: image_str)
                            }) {
                                if image_str.count>0 {
                                    Image(uiImage: profile_image!)
                                        .resizable()
                                        //.scaledToFit()
                                        .scaledToFill()
                                        .frame(width: 120, height: 120)
                                }else{
                                    Rectangle().frame(width: 120, height: 120)
                                }
                            }
                        }
*/
                    }
                }//VStack
                .background(Image("background_image_l").resizable().scaledToFill().opacity(0.2))

                //if showingQrPopUp {
                //    QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
                //}
                if showingCameraPopUp {
                    QRCodeReaderView(isPresent: $showingCameraPopUp, person: self.$person)
                }
            /*NavigationLinkエリア@NavigationView*/
                Group{
                    //名刺交換
                    NavigationLink(
                        destination:BCExchangeView(),
                        isActive:$isActiveBCExchangeView
                    ) {
                        EmptyView()
                    }

                    //マイデータ
                    NavigationLink(
                        destination:MyDataView(person: self.$person),
                        isActive:$isActiveMyDataView
                    ) {
                        EmptyView()
                    }

                    //会議レイアウト
                    NavigationLink(
                        //destination:MeetingLayoutView(),
                        destination:MeetingList(),
                        isActive:$isActiveMeetingLayoutView
                    ) {
                        EmptyView()
                    }
                    //連絡先
                    NavigationLink(
                        destination:UserDataList(),
                        isActive:$isActivePersonDataView
                    ) {
                        EmptyView()
                    }

                    //取説ページ
                    NavigationLink(
                        destination:WebView(loadUrl: "https://www.ganasonic.com/mayca.html"),
                        isActive:$isActiveMayCaDocumentView
                    ) {
                        EmptyView()
                    }
                    //マイデータ転送設定
                    NavigationLink(
                        destination:MyDataSettingView(),
                        isActive:$isActiveMyDataSettingView
                    ) {
                        EmptyView()
                    }

                    //リザーブ
                    NavigationLink(
                        destination:CategoryRegistView(category: ""),
                        isActive:$isActiveReserve1View
                    ) {
                        EmptyView()
                    }
                }
                Group{
                    
                    NavigationLink(
                        destination: QRCodeView(isPresent: $showingQrPopUp, person: self.$person),
                        isActive: self.$showingQrPopUp
                    ) {
                        EmptyView()
                    }
                    NavigationLink(
                        destination: QRCode2UserDetail(scanedString:QrCodeString, isPresent: $isPresent),
                        isActive: self.$isActiveBCExchangeView
                    ) {
                        EmptyView()
                    }
                    /*
                    //リザーブ
                    NavigationLink(
                        destination:EmptyView(),
                        isActive:$isActiveReserve2View
                    ) {
                        EmptyView()
                    }
                    //メンテナンス
                    NavigationLink(
                        destination:MaintenanceView(),
                        isActive:$isActiveMaintenanceView
                    ) {
                        EmptyView()
                    }*/
                }
            }//ZStack
            /*
            .sheet(
                isPresented: $isActiveImagePickerView,
                /*画面を閉じた時に実行する処理を指定*/
                onDismiss: {
                    getQRcodeString(image: self.qr_image)
                    self.isActiveBCExchangeView.toggle()
                    print("画面を閉じた")
                    }
            ) {
                ImagePickerView(image: self.$qr_image)
            }
            */
            .sheet(isPresented: $showingQrPopUp) {
                QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarTitle("MayCa").font(.system(size: 18))
            //ナビゲーションの部分にアイコン・ボタンを追加
            .navigationBarItems(leading: 
                HStack {
                    Button(action: {
                        print("左のボタンが押されました。")
                        self.isActiveMayCaDocumentView.toggle()
                    }, label: {
                        Image(systemName: "book")
                    }
                    )
                    Spacer()
                }
            )

        }//NavigationView
        .onAppear(perform: {
            person = DB_Manager().getUser(idValue: g_index)
            if person.id == 0 {
                isActiveMyDataView = true
            }
            print("g_index \(g_index)")
        })
    }

    init() {
        setupNavigationBar()
        let path:String = UserDefaults.standard.string(forKey: "avater") ?? "avater"
        print("path:\(path)")
        profile_image = loadImageFromPath(path: path)
        if profile_image == nil {
            print("profile_image :\(profile_image)")
        }else{
            print("画像取得できたよ")
        }
    }

    func getQRcodeString(image: UIImage?) {
        //画像を変換
        guard let img = image else { return }
        let ciImage = CIImage(image: img)!
        var message:String?
        //画像内にQRコードがあるか調べる
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)
        let features = detector?.features(in: ciImage)
        message = ""
        for feature in features  as! [CIQRCodeFeature] {
            message! += feature.messageString!
        }
        //テキストに表示
        if(message == "") {
            self.QrCodeString = "QRコードは検出されませんでした";
        } else {
            self.QrCodeString = message!
            print(self.QrCodeString)
        }
    }
     
    func setupNavigationBar() {
        //let bg_image = UIImage(named: "maru")
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        //appearance.backgroundColor = .gray //.blue //UIColor.init(red: 51/255, green: 0, blue: 255/255, alpha: 1)
        appearance.backgroundColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 0.9)
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        (UINavigationBar.appearance() as UINavigationBar).setBackgroundImage(bg_image, for: .default)

        // ナビゲーションバーの背景の透過

        // ナビゲージョンアイテムの文字色
        UINavigationBar.appearance().tintColor = UIColor.white
        // ナビゲーションバーのタイトルの文字色
        //UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]
        /*
        // ナビゲーションバーのタイトルの文字色
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
        // ナビゲーションバーの背景色
        UINavigationBar.appearance().barTintColor = UIColor.yellow
        // ナビゲーションバーの背景の透過
        (UINavigationBar.appearance() as UINavigationBar).setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの下の影を無くす
        UINavigationBar.appearance().shadowImage = UIImage()
*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//アプリ内に画像が保存してあるか否かの判定
func loadImageFromPath(path: String) -> UIImage? {
    let image = UIImage(contentsOfFile: path)
    if image == nil {
        print("missing image at: \(path)")
    }
    return image
}

