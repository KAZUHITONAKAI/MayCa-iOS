//
//  PopupQRCodeReaderView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/09.
//

import SwiftUI
//import PartialSheet

struct QRCodeReaderView: View {
    @Binding var isPresent: Bool
    @Binding var person: UserModel
    @ObservedObject var viewModel = ScannerViewModel()
    @State var showingPopUp = false
    @State var showingQrPopUp = false
    @State var isActiveImagePickerView = false
    //@State var isActiveBCExchangeView = false
    @State private var qr_image: UIImage?
    @State var QrCodeString:String = ""

    var body: some View {
        ZStack{
            VStack(alignment: .center){
                QrCodeScannerView()
                    .found(r: self.viewModel.onFoundQrCode)
                    .interval(delay: self.viewModel.scanInterval)
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer()
                HStack{
                    Spacer()
                    //QRコード表示
                    Button(action: {
                        self.showingQrPopUp.toggle()
                        /*
                        self.partialSheetManager.showPartialSheet(content: {
                            VStack {
                                Image(TComponent.resourcesLoadImage(name: "shinman"), scale: 2, label: Text("") ).clipShape(Circle())
                                    .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                                Text("ジャック")
                            }.frame(height: 200)
                        })
                        */
                        print("")
                    }) {
                        Image(systemName: "qrcode")
                        Text("QR画像表示")
                    }
                    Spacer()
                    Button(action: {
                        self.isActiveImagePickerView.toggle()
                    }) {
                        HStack{
                        Image(systemName: "qrcode")
                        Text("QR画像から読込")
                        }
                    }
                    /*
                    Button(action: {
                        withAnimation {
                            //showingPopUp = false
                            isPresent = false
                        }
                    }) {
                        //Image(systemName: "xmark.circle")
                        Text("閉じる")
                    }
                    */
                    Spacer()
                }
                Spacer()
                Divider()
                Button(action: {
                    withAnimation {
                        //showingPopUp = false
                        isPresent = false
                    }
                }) {
                    Image(systemName: "xmark.circle")
                    Text("閉じる")
                }
                Spacer()
                Text("latitude:\(location.latitude) longtitude:\(location.longitude)")
                 .font(.system(size: 12))
            }
            //.frame(maxWidth: .infinity, alignment: .center)
            .frame(width: screen_info.width, height: screen_info.height*0.7, alignment: .center)
            .padding(15)
            .background(Color(.white))
            .background(Image("businesscard_background").resizable().scaledToFill().opacity(0.2))
            .cornerRadius(15)
        }
        .sheet(isPresented: $showingQrPopUp) {
            QRCodeView(isPresent: $showingQrPopUp, person: self.$person)
                //.frame(width: screen_info.width*0.8, height: screen_info.height*0.7, alignment: .center)
        }
        .sheet(
            isPresented: $isActiveImagePickerView,
            /*画面を閉じた時に実行する処理を指定*/
            onDismiss: {
                getQRcodeString(image: self.qr_image, QrCodeString: &self.viewModel.lastQrCode)
                //self.isActiveBCExchangeView.toggle()
                self.viewModel.isFound = true
                print("画面を閉じた")
                }
        ) {
            ImagePickerView(image: self.$qr_image, image_type: "qrcode")
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
            current_qr_status = 0
            print("onAppear")
        })
        .onDisappear {
            print("onDisappear")
            isPresent = false
        }
    }
}

