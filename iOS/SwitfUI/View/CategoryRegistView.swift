//
//  CategoryRegistView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/10.
//

import SwiftUI

var g_category:String = ""

struct CategoryRegistView: View {
    // create variables to store user input values
    @State var category: String
    @State var categoryModels: [CategoryModel] = []
    // check if user is selected for edit
    @State var categorySelected: Bool = false
    // id of selected user to edit or delete
    @State var selectedId: Int64 = 0

    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @Environment(\.editMode) var editMode
    @Environment(\.presentationMode) var presentation
    @State private var items = [""]

    var body: some View {
        VStack {
            //広告ビュー
            AdView().frame(width: 320, height: 50, alignment: .center)
            List {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
            }//List
            .toolbar {
                EditButton()
            }
            Spacer()
            Text("カテゴリの新規追加")
            TextField("カテゴリ", text: $category, onCommit: {updateDb()}).environment(\.isEnabled, true)
                .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
            
        }.padding()
        .navigationBarTitle("カテゴリ登録").font(.system(size: 18))
        .navigationBarItems(leading:
                                Button(action: {
                                    print("左のボタンが押されました。")
                                    //self.isActiveMayCaDocumentView.toggle()
                                }, label: {
                                    //Text("連絡先")
                                }
                                )
        )

        .onAppear(perform: {
            reload()
        })
        .onDisappear(perform: {
            //self.selection = g_selection
            self.categoryModels = DB_ManagerCategory().getCategories()
            for categoryModel in categoryModels {
                print("delete  \(categoryModel.id) \(categoryModel.category)")
                DB_ManagerCategory().deleteCategory(idValue: categoryModel.id)
            }
            //
            for item in items.reversed() {
                print("add  \(item)")
                DB_ManagerCategory().addCategory(categoryValue: item)
            }
        })
    }

    func updateDb() {
        DB_ManagerCategory().addCategory(categoryValue: self.category)
        reload()
        self.category = ""
    }

    func reload() {
        //let dbManager: DB_ManagerCategory = DB_ManagerCategory()
        //self.categoryModels = dbManager.getCategories()
        items.removeAll()
        self.categoryModels = DB_ManagerCategory().getCategories()
        
        for categoryModel in categoryModels {
            items.append(categoryModel.category)
        }
    }

    func move(from source: IndexSet, to destination: Int) {
        items.move(fromOffsets: source, toOffset: destination)
    }
    
    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

}

struct CategoryRegistView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRegistView(category: "SKI")
    }
}
