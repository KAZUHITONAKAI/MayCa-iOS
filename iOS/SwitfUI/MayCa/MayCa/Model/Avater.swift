//
//  Avater.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/09.
//

import SwiftUI

struct Avater: View {
    @State var Name:String = ""
    @State var ImageName:String = "avatar_s"
    @State var x = 0
    @State var y = 0
    @State var width:CGFloat = 0
    @State var height:CGFloat = 0
    @State var color = Color.blue
    @State var linewidth:CGFloat = 2


    var body: some View {
        VStack{
            Image(self.ImageName)
            Text(self.Name)
                .font(.system(size: 12))
                .border(self.color, width: self.linewidth)
        }
    }
}
