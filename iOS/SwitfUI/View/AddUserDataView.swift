//
//  AddUserDataView.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import SwiftUI

struct AddUserDataView: View {
    @State var userdata: UserDataModel = UserDataModel()

    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("項目名:")
                    .font(.callout)
                    .bold()
                TextField("項目名", text: $userdata.userkey)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                Spacer()
            }
            //.padding()
            HStack {
                Spacer()
                Text("データ:")
                    .font(.callout)
                    .bold()
                TextField("データ", text: $userdata.uservalue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                Spacer()
            }

            HStack {
                Spacer()
                //保存
                Button(action: {
                    saveDb()
                    print("save")
                }) {
                    Text("登録")
                }
            }
            Spacer()
        }
        .padding()
        .background(Color(.white))
        .navigationBarTitle("ユーザデータ追加").font(.system(size: 18))
    }

    func saveDb() {
        if userdata.userkey.count > 0 && userdata.uservalue.count > 0 {
            DB_ManagerUserData().addUserData(userkeyValue:userdata.userkey, uservalueValue:userdata.uservalue)
            // go back to home page
            self.mode.wrappedValue.dismiss()
            print("saveDb saved")
        }else{
            print("saveDb not saved")
        }
    }
}
