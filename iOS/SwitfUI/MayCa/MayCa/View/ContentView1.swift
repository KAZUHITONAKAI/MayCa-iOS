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

    @State private var qr_image: UIImage?
    @State var QrCodeString:String = ""
    @State var isPresent = false
    @State var profile_image:UIImage?
    @State var image_str:String = ""

    var body: some View {

        NavigationView {
            ZStack{
                VStack(alignment: .center){
                    BusinessCardView(person: $person)
                    .padding()
                    //HStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        LazyHStack(spacing: 4){
                        //Spacer()
                        //名刺交換
                        Button(action: {
                            //withAnimation {
                                showingQrPopUp = true
                            //}
                            print("Show my QR Code")
                        }) {
                            Image("qr80")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }

                        //名刺交換
                        Button(action: {
                            withAnimation {
                                showingCameraPopUp = true
                            }
                            //self.isActiveBCExchangeView.toggle()
                            print("Show QR Code Reader")
                            //self.isActiveBCExchangeView.toggle()
                            print("")
                        }) {
                            Image("MayCaIcon256")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }

                        //マイデータ
                        Button(action: {
                            self.isActiveMyDataView.toggle()
                            print("")
                        }) {
                            Image("MayData256")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }

                        //連絡先
                        Button(action: {
                            self.isActivePersonDataView.toggle()
                            print("")
                        }) {
                            Image("MayAddress256")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }

                        /*
                        //カテゴリ登録
                        Button(action: {
                            //self.isActiveReserve1View.toggle()
                            self.isActiveReserve2View.toggle()
                            print("")
                        }) {
                            Image("MayCategory256")
                                .resizable()
                                .frame(width: 80, height: 80)
                        }*/


                        }//LazyHStack
                    }//ScrollView
                    .frame(width: screen_info.width*0.9, alignment: .leading)
                    Spacer()
                    if profile_image != nil {
                        Image(uiImage: profile_image!)
                            .resizable()
                            //.scaledToFit()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                    }
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
                            let fileURL:URL = URL(fileURLWithPath: image_str)
                            profile_image = UIImage(contentsOfFile: fileURL.path)
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
                    //広告ビュー
                    AdView()
                }//VStack
                .background(Image("background_image_l").resizable().scaledToFill().opacity(0.2))

                if showingQrPopUp {
                    QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
                }
                if showingCameraPopUp {
                    QRCodeReaderView(isPresent: $showingCameraPopUp)
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
            //.sheet(isPresented: $showingQrPopUp) {
            //        QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
            //}
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
            /*
            , trailing: 
                HStack {
                    /*
                    Button(action: {
                        print("右のボタン１が押されました。")
                        self.isActiveBCExchangeView.toggle()
                    }, label: {
                        Image(systemName: "qrcode")
                    })*/
                    Button(action: {
                        print("右のボタン１が押されました。")
                        self.isActiveImagePickerView.toggle()
                    }, label: {
                        Image(systemName: "qrcode")
                        //Image(systemName: "photo")
                    })
                    Spacer()
                    Spacer()
                    Button(action: {
                        //マイデータ転送設定
                        self.isActiveMyDataSettingView.toggle()
                        print("右のボタン２が押されました。")
                    }, label: {
                        Image(systemName: "gearshape.2.fill")
                    })
                    Spacer()
                }
            */)

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
        profile_image = UIImage(contentsOfFile: path)
        if profile_image == nil {
            print("profile_image :\(profile_image)")
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
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .blue //UIColor.init(red: 51/255, green: 0, blue: 255/255, alpha: 1)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


