//
//  MaintenanceView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/02.
//

import SwiftUI

struct MaintenanceView: View {
	// array of user models
	@State var userModels: [UserModel] = []

	// check if user is selected for edit
	@State var userSelected: Bool = false
	 
	// id of selected user to edit or delete
	@State var selectedUserId: Int64 = 0
    
    @State var index: Int64 = 1
    
    var showAlert = AlertDialog()
    

    var body: some View {
        VStack {
     
            // create link to add user
            HStack {
                
                Stepper(value: $index, in: 1...10) {
                    Text("\(index, specifier: "%d") 番目")
                    
                    //g_index = index
                }
                Spacer()
                NavigationLink (destination: AddUserView(), label: {
                    Text("ユーザ追加")
                })
            }

            // navigation link to go to edit user view
            NavigationLink (destination: EditUserView(id: self.$selectedUserId), isActive: self.$userSelected) {
                EmptyView()
            }


            // list view goes here
            // create list view to show all users
            List (self.userModels) { (model) in
             
                // show name, email, and age horizontally
                HStack {
                    Text(model.company1)
                    VStack{
                        Text(model.department)
                        Text(model.fullname)
                    //Text("\(model.age)")
                    }
                    Spacer()
                    // button to edit user
                    Button(action: {
                        self.selectedUserId = model.id
                        //AlertDialog.showAlert(title: "編集するよ", message: "メッセージ", buttonTitle: "閉じる", viewController: self)
                        self.userSelected = true
                    }, label: {
                        Text("編集")
                            .foregroundColor(Color.blue)
                        })
                        // by default, buttons are full width.
                        // to prevent this, use the following
                        .buttonStyle(PlainButtonStyle())
                     
                    // button to delete user
                    Button(action: {
             
                        // create db manager instance
                        let dbManager: DB_Manager = DB_Manager()
             
                        // call delete function
                        dbManager.deleteUser(idValue: model.id)
             
                        // refresh the user models array
                        self.userModels = dbManager.getUsers()
                    }, label: {
                        Text("削除")
                            .foregroundColor(Color.red)
                    })// by default, buttons are full width.
                    // to prevent this, use the following
                    .buttonStyle(PlainButtonStyle())
                }
            }

        }.padding()
        // load data in user models array
        .onAppear(perform: {
            self.userModels = DB_Manager().getUsers()
        })
        .onDisappear(perform: {
            g_index = getIndex()
            print("g_index")
            print(g_index)
        })
        
        .navigationBarTitle("開発用")
    }
    
    public func getIndex() -> Int64 {
        return index
    }
}

struct MaintenanceView_Previews: PreviewProvider {
    static var previews: some View {
        MaintenanceView()
    }
}
