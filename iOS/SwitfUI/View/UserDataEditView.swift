//
//  UserDataEditView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/10.
//

import SwiftUI

struct UserDataEditView: View {
    // create variables to store user input values
    @State var userkey: String = ""
    @Binding var userdatas: [UserDataModel]// = []
    @State var userdata: UserDataModel = UserDataModel()
    // check if user is selected for edit
    @State var categorySelected: Bool = false
    // id of selected user to edit or delete
    @State var selectedId: Int64 = 0

    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.editMode) var editMode
    @Environment(\.presentationMode) var presentation
    struct strContent : Hashable{
        var id:String
        var key:String
        var value:String
    }
    @State private var items: [strContent] = []

    var body: some View {
        NavigationView{
            VStack {
                Form{
                    List {
                        ForEach(items, id: \.self) { item in
                            HStack{
                                Text(item.id)
                                Text(item.key)
                                Text(item.value)
                            }
                        }
                        .onDelete(perform: delete)
                    }//List
                }
                /*
                HStack{
                    Image(systemName: "pencil.circle")
                    EditButton()
                    Spacer()
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                        Text("閉じる")
                    }
                }*/
                //Text("ユーザデータ編集画面")
                //    .font(.system(size: 22))
                //    .foregroundColor(.blue)
                //Divider()
                //広告ビュー
                AdView().frame(width: 320, height: 50, alignment: .center)
                //Spacer()
                Spacer()
                Text("ユーザデータの新規追加")
                VStack {
                    TextField("ユーザ項目名", text: $userdata.userkey, onCommit: {registUserData()}).environment(\.isEnabled, true)
                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                    //TextField("ユーザデータ", text: $userdata.uservalue, onCommit: {registUserData()}).environment(\.isEnabled, true)
                    //    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                }
                
            }.padding()
            //.navigationBarTitle("ユーザデータ編集画面").font(.system(size: 18))
            .navigationBarTitle("非公開データ情報",displayMode: .inline)
            .navigationBarItems(
                leading:
//                    Image(systemName: "pencil.circle")
                    EditButton()
                ,
                trailing:
                    Button(action: {
                        self.mode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark.circle")
                        Text("閉じる")
                    }
            )
            .onAppear(perform: {
                items.removeAll()
                for userdata in userdatas {
                    let tmp:strContent = strContent(id: String(userdata.id), key: userdata.userkey, value: userdata.uservalue)
                    items.append(tmp)
                }
            })
            .onDisappear(perform: {
            })
        }
    }

    func registUserData() {
        if userdata.userkey.count > 0 /*&& userdata.uservalue.count > 0*/ {
            DB_ManagerUserData().addUserData(userkeyValue:userdata.userkey, uservalueValue:userdata.uservalue)
            // go back to home page
            self.mode.wrappedValue.dismiss()
            print("saveDb saved")
        }else{
            print("saveDb not saved")
        }
        reload()
        self.userkey = ""
    }

    func reload() {
        items.removeAll()
        self.userdatas = DB_ManagerUserData().getUserDatas()
        for userdata in userdatas {
            let tmp:strContent = strContent(id: String(userdata.id), key: userdata.userkey, value: userdata.uservalue)
            items.append(tmp)
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }

    func delete(at offsets: IndexSet) {
        let index:Int = offsets.first!
        print("index \(index)")
        let id:Int64 = Int64(items[index].id) ?? 0
        print("id    \(id)")
        print("key   \(items[index].key)")
        print("value \(items[index].value)")
        items.remove(atOffsets: offsets)
        
        DB_ManagerUserData().deleteUserData(idValue: id)
        reload()
    }

}
