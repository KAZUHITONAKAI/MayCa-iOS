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

    var body: some View {

        NavigationView {
            ZStack{
                VStack {
                    //ScrollView{
                        VStack(alignment: .center){
                            BusinessCardView(person: $person)
                            .padding()
                            //HStack{
                            ScrollView(.horizontal, showsIndicators: false){
                                LazyHStack(spacing: 12){
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
                                //.frame(width: 40, height: 40)
                                //.padding()
                                /*
                                VStack (alignment: .leading){
                                    /*
                                    Toggle(isOn: $isEnableSendData) {
                                        Text(isEnableSendData ? "マイデータ送信可":"マイデータ送信不可")
                                            .font(.system(size: 12))
                                    }*/
                                    Text("")
                                    .padding()
                                    .frame(width: 200, height: 30)
                                    
                                    Spacer()
                                    /*
                                    Toggle(isOn: $isEnableSendApp) {
                                        Text(isEnableSendApp ? "MayCa App送信可":"MayCa App送信不可")
                                            .font(.system(size: 11))
                                    }*/
                                    Text("")
                                    .padding()
                                    .frame(width: 200, height: 30)
                                }
                                */
                                
                                //Spacer()

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

                                //カテゴリ登録
                                Button(action: {
                                    self.isActiveReserve1View.toggle()
                                    print("")
                                }) {
                                    Image("MayCategory256")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                }


                                }//LazyHStack
                            }//ScrollView

/*
                            //マイデータ
                            Button(action: {
                                self.isActiveMyDataView.toggle()
                                print("")
                            }) {
                                Text("マイデータ")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
                            
                            //連絡先
                            Button(action: {
                                self.isActivePersonDataView.toggle()
                                print("")
                            }) {
                                Text("連絡先")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
*/

/*
                            //会議レイアウト
                            Button(action: {
                                self.isActiveMeetingLayoutView.toggle()
                                print("")
                            }) {
                                Text("会議モード")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
                            
                            //マイデータ転送設定
                            Button(action: {
                                self.isActiveMyDataSettingView.toggle()
                                print("")
                            }) {
                                Text("")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
        
                            //マイカショップ
                            Button(action: {
                                self.isActiveMayCaShopView
                                    .toggle()
                                print("")
                            }) {
                                Text("")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
*/

/*
                            //reserve
                            Button(action: {
                                self.isActiveReserve1View.toggle()
                                print("")
                            }) {
                                Text("カテゴリ登録")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
*/

        /*
                            //reserve
                            Button(action: {
                                self.isActiveReserve2View.toggle()
                                print("")
                            }) {
                                Text("")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
                            
                            //reserve
                            Button(action: {
                                self.isActiveMaintenanceView.toggle()
                                print("")
                            }) {
                                Text("")
                                    .frame(width: 260, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            }
                            .padding()
                            .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            .background(Color.white)
                            .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                            .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )

        */
                            Spacer()
                            //広告ビュー
                            AdView()
                            Spacer()
                        }

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
        /*
                        //マイカショップ
                        NavigationLink(
                            destination:WebView(loadUrl: "https://www.theoceanstyle.com/blank-14"),
                            isActive:$isActiveMayCaShopView
                        ) {
                            EmptyView()
                        }
        */
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
                            destination:CategoryTestView(category: ""),
                            isActive:$isActiveReserve1View
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
                        }
*/
                    //}//ScrollView
                    /*
                    if showingQrPopUp {
                        QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
                    }
                    if showingCameraPopUp {
                        QRCodeReaderView(isPresent: $showingCameraPopUp)
                    }*/
                }//VStack
                .background(Image("background_image_l").resizable().scaledToFill().opacity(0.2))

                if showingQrPopUp {
                    QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
                }
                if showingCameraPopUp {
                    QRCodeReaderView(isPresent: $showingCameraPopUp)
                }

            }//ZStack
            //.sheet(isPresented: $showingQrPopUp) {
            //        QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
            //}
            .navigationViewStyle(StackNavigationViewStyle())
            //NavigationLink(destination: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Destination@*/Text("Destination")/*@END_MENU_TOKEN@*/) { /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Navigate")/*@END_MENU_TOKEN@*/ }


            .navigationBarTitle("MayCa").font(.system(size: 18))
            .navigationBarItems(leading: Button(action: {
                print("左のボタンが押されました。")
                self.isActiveMayCaDocumentView.toggle()
            }, label: {
                Image(systemName: "book.circle")
            }), trailing: HStack {
                Button(action: {
                    print("右のボタン１が押されました。")
                    self.isActiveBCExchangeView.toggle()
                }, label: {
                    Image(systemName: "camera")
                })
                Button(action: {
                    //マイデータ転送設定
                    self.isActiveMyDataSettingView.toggle()
                    print("右のボタン２が押されました。")
                }, label: {
                    Image(systemName: "gearshape.2.fill")
                })
            })
        }
        .onAppear(perform: {
            person = DB_Manager().getUser(idValue: g_index)
            
            if person.id == 0 {
                isActiveMyDataView = true
            }
            
            //g_selection = UserDefaults.standard.integer(forKey: "category_selected_index")
            //print("g_selection \(g_selection)")
            print("g_index \(g_index)")
        })
    }

    init() {
        setupNavigationBar()
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


