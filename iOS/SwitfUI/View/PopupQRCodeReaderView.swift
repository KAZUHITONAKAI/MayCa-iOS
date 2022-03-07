//
//  PopupQRCodeReaderView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/09.
//

import SwiftUI

struct PopupQRCodeReaderView: View {
    @Binding var isPresent: Bool
    @ObservedObject var viewModel = ScannerViewModel()
    @State var showingPopUp = false
    var body: some View {
        ZStack{
            VStack(alignment: .center){
                QrCodeScannerView()
                    .found(r: self.viewModel.onFoundQrCode)
                    .interval(delay: self.viewModel.scanInterval)
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
/*
                Button(action: {
                    withAnimation {
                        showingPopUp = true
                    }
                }) {
                    Text("QRコード表示")
                }
*/
                Button(action: {
                    withAnimation {
                        //showingPopUp = false
                        isPresent = false
                    }
                }) {
                    Text("閉じる")
                }
                Text("latitude:\(location.latitude) longtitude:\(location.longitude)")
                 .font(.system(size: 12))
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(15)
            //.background(Color(.secondarySystemFill))
            .background(Color(.white))
            .cornerRadius(15)

 //           if showingPopUp {
 //               PopupView(isPresent: $showingPopUp)
 //           }
        }
        .navigationBarTitle(Text("QRコード読み取り"))
        //
        NavigationLink(
            destination: QRCode2UserDetail(scanedString:self.viewModel.lastQrCode, isPresent: $isPresent),
            isActive: self.$viewModel.isFound
        ) {
            EmptyView()
        }
        .onAppear(perform: {
            print("onAppear")
        })
        .onDisappear {
            print("onDisappear")
            isPresent = false
        }
    }
}

