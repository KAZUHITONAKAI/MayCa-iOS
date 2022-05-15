//
//  AddCategoryView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/10.
//

import SwiftUI

struct AddCategoryView: View {
    // create variables to store user input values
    @State var category: String = ""
    @State private var items = ["仕事", "SKI", "飲み", "地元", "大学"]
    @State var categoryModels: [CategoryModel] = []

    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
     
    var body: some View {
        ScrollView{
            VStack {
                Text("カテゴリリスト")
                List {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                    .onDelete(perform: delete)
                }
                Text("カテゴリ追加")
                HStack {
                    Text("カテゴリ:")
                        .font(.callout)
                        .bold()
                    TextField("カテゴリ", text: $category)
                        .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                }
                Spacer()
                Text("カテゴリリスト")
                List (categoryModels) { categoryModel in
                    Text(categoryModel.category)
                }
                
                MyEditButton()  // オリジナルEditButtonに置き換え
                
                HStack {
                    Spacer()
                    //保存
                    NavigationLink(destination: EmptyView()) {
                        Button(action: {
                            DB_ManagerCategory().addCategory(categoryValue:self.category)

                            // go back to home page
                            self.mode.wrappedValue.dismiss()
                            print("save")
                        }) {
                            //CircleImage(image: Image("save"))
                            Text("保存")
                        }
                    }
                }
            }.padding()
            .navigationBarTitle("カテゴリ追加").font(.system(size: 18))
            .onAppear(perform: {
                self.categoryModels = DB_ManagerCategory().getCategories()
            })
        }
    }

    func delete(offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

}

struct AddCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        AddCategoryView()
    }
}

/// オリジナルEditButton
struct MyEditButton: View {
    @Environment(\.editMode) var editMode
    
    var body: some View {
        Button(action: {
            withAnimation() {
                if editMode?.wrappedValue.isEditing == true {
                    editMode?.wrappedValue = .inactive
                } else {
                    editMode?.wrappedValue = .active
                }
            }
        }) {
            if editMode?.wrappedValue.isEditing == true {
                Text("終了")
            } else {
                Text("編集")
            }
        }
    }
}
