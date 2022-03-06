//
//  PopupQRCodeReaderView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/09.
//

import SwiftUI

struct PopUpMapView: View {
    var latitude: String
    var longitude: String
    @Binding var isPresent: Bool
    @State var showingPopUp = false
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                MapView(latitude: latitude,longitude: longitude)
                    .edgesIgnoringSafeArea(.top)
                    .frame(width:300, height: 300)
                Button(action: {
                    withAnimation {
                        //showingPopUp = false
                        isPresent = false
                    }
                }) {
                    Text("閉じる")
                }
                Text("latitude:\(self.latitude) longtitude:\(self.longitude)")
                 .font(.system(size: 12))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(15)
            .background(Color(.white))
            .cornerRadius(15)
        }
        .navigationBarTitle(Text("QRコード読み取り"))
    }
}

