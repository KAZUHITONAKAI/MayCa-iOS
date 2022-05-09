//
//  PopupCategoryView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/23.
//

import SwiftUI

struct PopupCategoryView: View {
    @Binding var isPresent: Bool
    @Binding var userdata_category: String
    @State var selection: Int = 0
    @State var categoryModels: [CategoryModel] = []
    var text_width:CGFloat = screen_info.width*0.6
    var picker_width:CGFloat = screen_info.width*0.8
    var wnd_width:CGFloat = screen_info.width*0.9

    var body: some View {
        VStack{
            HStack{
                //Spacer()
                Text("カテゴリ選択")
                Spacer()
                Button(action: {
                    withAnimation {
                        isPresent = false
                    }
                }, label: {
                    Image(systemName: "xmark.circle")
                    Text("閉じる")
                })
                //Spacer()
            }.padding()
            Form{
                Picker(selection: $selection, label: Text("カテゴリ")){
                    ForEach(0 ..< self.categoryModels.count) {
                        Text(self.categoryModels[$0].category).tag($0)
                            .frame(width: text_width,alignment: .leading)
                    }
                }
                .frame(width: picker_width, alignment: .leading)
                .onChange(of: self.selection){_ in
                    print("selected \(self.selection) " + self.categoryModels[self.selection].category)
                    userdata_category = self.categoryModels[self.selection].category
                    isPresent = false
                }.pickerStyle(WheelPickerStyle())
                .onTapGesture(perform: {
                    self.selection = 0
                    userdata_category = self.categoryModels[self.selection].category
                    isPresent = false
                })
            }
            //
        }
        .frame(width: wnd_width, height: 340, alignment: .center)
        .background(Color.white)
        .border(Color.gray, width: 1)
        .cornerRadius(5)
        .onAppear(perform: {
            self.categoryModels = DB_ManagerCategory().getCategories()
            var i = 0
            for category in self.categoryModels {
                if userdata_category == category.category {
                    self.selection = i
                }
                i = i + 1
            }
        })
    }
}
