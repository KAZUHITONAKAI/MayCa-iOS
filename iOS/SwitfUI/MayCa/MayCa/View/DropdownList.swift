//
//  DropdownList.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/17.
//

import SwiftUI

struct DropdownList<Content: CustomStringConvertible & Hashable>: View {
    @State var categoryModels: [CategoryModel] = []
    private let list: [Content]
    @Binding var selected: CategoryModel
    var body: some View {
        Menu {
            ForEach(self.categoryModels) { category in
            //ForEach(list, id: \.self) { content in
                Button {
                    selected = category
                } label: {
                    Text(category.category)
                }
            }
        } label: {
            HStack {
                Text(selected.category).lineLimit(1)
                Text("▼")
            }
        }
        .navigationBarTitle("カテゴリ追加").font(.system(size: 18))
        .onAppear(perform: {
            self.categoryModels = DB_ManagerCategory().getCategories()
        })
    }
}
