import SwiftUI

//var g_selection: Int = -1

struct UserDataList: View {
    // array of user models
    @State var userModels: [UserModel] = []
    @State var selection: Int = 0
    @State var categoryModels: [CategoryModel] = []
    @State private var items = [""]
    @State var isActiveAddUserView = false

    @State var isActiveCategoryView = false
    @State var isActiveBCExchangeView = false
    @State var isActiveImagePickerView = false
    @State private var qr_image: UIImage?
    @State var QrCodeString:String = ""
    @State var isPresent = false
    @State var showingQrPopUp = false
    @State var person: UserModel = UserModel.init()
    @State var showingAlert = false
    @State var selectedUserId: Int64 = 0
    @State var isEditView = false

    var body: some View {
        VStack {
            //広告ビュー
            //AdView().frame(width: 320, height: 50, alignment: .center)
            Form{
                //カテゴリ選択
                Picker(selection: $selection, label: Text("カテゴリ")){
                    ForEach(0 ..< self.items.count) {
                        Text(self.items[$0]).tag($0)
                    }
                }.onChange(of: self.selection){_ in
                    print("selected \(self.selection) " + self.items[self.selection])
                    userModels = DB_Manager().getUsersByCategory(selected_category: self.items[self.selection])
                }
                //
                HStack{
                    NavigationLink(
                        destination:CategoryRegistView(category: "")
                        /*,isActive:$isActiveCategoryView*/
                    ) {
                        Button(action: {
                            //self.isActiveCategoryView.toggle()
                        }) {
                            HStack{
                            Image(systemName: "tag")
                            Text("カテゴリ登録")
                            }
                        }
                    }
                    Spacer()
                }//
                //
                HStack{
                    NavigationLink(destination: AddUserView()) {
                        Button(action: {
                            print("")
                        }) {
                            HStack{
                            Image(systemName: "person.badge.plus")
                            Text("手動ユーザ追加")
                            }
                        }
                    }
                    Spacer()
                }//
                //
                HStack{
                    Button(action: {
                        self.isActiveImagePickerView.toggle()
                    }) {
                        HStack{
                        Image(systemName: "qrcode")
                        Text("QRコードから読み込み")
                        }
                    }
                    Spacer()
                }//
                /*
                HStack{
                    Button(action: {
                        print("連絡先をエクスポート")
                    }) {
                        HStack{
                        Image(systemName: "square.and.arrow.up")
                        Text("連絡先をエクスポート")
                        }
                    }
                    Spacer()
                }*/
            //}
            //Divider()
            //Form{
                //ユーザリスト
                List (self.userModels) { userdata in
                    NavigationLink(destination: UserDataDetail(person: userdata)) {
                        UserDataRow(userdata: userdata)
                            .contextMenu(ContextMenu(menuItems: {
                                Button(action: {
                                    UIApplication.shared.open(URL(string: AppSNSLink.link_tel+userdata.tel)!)
                                }){
                                    Label("電話する", systemImage:"phone.arrow.up.right")
                                }
                                Button(action: {
                                    UIApplication.shared.open(URL(string:  AppSNSLink.link_email+userdata.email)!)
                                }){
                                    Label("メールする", systemImage:"envelope")
                                }
                                //QRコード表示
                                Button(action: {
                                    showQRcodeAction(userdata: userdata)
                                }) {
                                    Image(systemName: "qrcode")
                                    Text("QR画像表示")
                                }

                                Button(action: {
                                    self.selectedUserId = userdata.id
                                    isEditView.toggle()
                                }) {
                                    Image(systemName: "pencil")
                                    Text("編集する")
                                }
                                //

                                Button(action: {
                                    deleteAction(userdata: userdata)
                                }) {
                                    Image(systemName: "delete.backward")
                                    Text("削除する")
                                }
                                
                            }))
                    }
                    .navigationBarTitle(Text("連絡先"))
                }
            }
        }//VStack
        .sheet(
            isPresented: $isActiveImagePickerView,
            /*画面を閉じた時に実行する処理を指定*/
            onDismiss: {
                getQRcodeString(image: self.qr_image, QrCodeString: &QrCodeString)
                self.isActiveBCExchangeView.toggle()
                print("画面を閉じた")
                }
        ) {
            ImagePickerView(image: self.$qr_image, image_type: "qrcode")
        }
        .sheet(isPresented: $showingQrPopUp) {
            QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("警告"), message: Text("マイデータは削除できません"))
        }
        /*
        .navigationBarItems(trailing: HStack {
            Button(action: {
                print("add")
                self.isActiveAddUserView.toggle()
            }, label: {
                Image("add")
            })
        })*/
        .onAppear(perform: {
            reloadAction()
            /*
            items.removeAll()
            self.categoryModels = DB_ManagerCategory().getCategories()
            items.append("All")
            for categoryModel in categoryModels {
                items.append(categoryModel.category)
            }
            self.userModels = DB_Manager().getUsersByCategory(selected_category: self.items[self.selection])
            */
            //self.userModels = DB_Manager().getUsersByCategory(selected_category: self.categoryModels[self.selection].category)
        })
        .onDisappear(perform: {
            //self.selection = g_selection
        })
        NavigationLink(
            destination:AddUserView(),
            isActive:$isActiveAddUserView
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: QRCode2UserDetail(scanedString:QrCodeString, isPresent: $isPresent),
            isActive: self.$isActiveBCExchangeView
        ) {
            EmptyView()
        }
        NavigationLink(
            destination: EditUserView(id: self.$selectedUserId),
            isActive: self.$isEditView
        ) {
            EmptyView()
        }
    }
    
    func reloadAction() {
        self.items.removeAll()
        self.categoryModels = DB_ManagerCategory().getCategories()
        self.items.append("All")
        for categoryModel in categoryModels {
            self.items.append(categoryModel.category)
        }
        self.userModels = DB_Manager().getUsersByCategory(selected_category: self.items[self.selection])
        //self.userModels = DB_Manager().getUsersByCategory(selected_category: self.categoryModels[self.selection].category)

    }

    func deleteAction(userdata:UserModel){
        if userdata.id > 1 {
            DB_Manager().deleteUser(idValue: userdata.id)
            reloadAction()
            self.showingAlert = false
        }else{
            self.showingAlert = true
        }
    }

    func showQRcodeAction(userdata:UserModel){
        self.person = userdata
        self.showingQrPopUp.toggle()
    }
}

struct UserDataList_Previews: PreviewProvider {
    static var previews: some View {
        UserDataList()
    }
}
