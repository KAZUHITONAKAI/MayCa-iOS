







//
//  BCExchangeView2.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/04/23.
//

import SwiftUI


struct BCExchangeView2: View {
    @ObservedObject var viewModel = ScannerViewModel()
    @State var scanedString:String = ""
    @State var correctionLevel = 0
    @State var qrImage:UIImage?
    private var _QRCodeMaker = QRCodeMaker()
    @State var isActiveView = false
    @State var isPresent = false

    var body: some View {
        VStack(alignment: .center){
            ZStack{
                QrCodeScannerView()
                    .found(r: self.viewModel.onFoundQrCode)
                    .interval(delay: self.viewModel.scanInterval)
                    .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)

                if qrImage != nil {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.white)
                        .frame(width: 320, height: 320, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(color: .gray, radius: 2, x:2, y:2  )
                    Image(uiImage: qrImage!)
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
            }
            //
            Button(action: {
                print(self.scanedString)
                self.viewModel.isShowing = false
                self.viewModel.isFound = false
                self.viewModel.lastQrCode = ""
                self.qrImage = self._QRCodeMaker.make(message: self.scanedString, level: self.correctionLevel)
            }) {
                Text("QRコード表示")
            }
            /*
            Text(self.viewModel.lastQrCode)
                .font(.system(size: 12))
            */
            Text("latitude:\(location.latitude) longtitude:\(location.longitude)")
             .font(.system(size: 12))

        }
        .navigationBarTitle(Text("QRコード読み取り"))
        //
        NavigationLink(
            destination: QRCode2UserDetail(scanedString:self.viewModel.lastQrCode, isPresent: $isPresent),
            /*isActive:$isActiveView*/
            isActive: self.$viewModel.isFound
        ) {
            EmptyView()
        }
        
        .onAppear(perform: {
            //self.viewModel.isFound = false
            let person: UserModel = DB_Manager().getUser(idValue: g_index)

             self.scanedString = "'category'=" + person.category + ",'fullname'=" + person.fullname + ",'fullyomi'=" + person.fullyomi + ",'company1'=" + person.company1 + ",'company1yomi'=" + person.company1yomi + ",'company2'=" + person.company2 + ",'department'=" + person.department + ",'section'=" + person.section + ",'role'=" + person.role + ",'zipcode'=" + person.zipcode + ",'address1'=" + person.address1 + ",'address2'=" + person.address2 + ",'tel'=" + person.tel + ",'fax'=" + person.fax + ",'email'=" + person.email + ",'facebook'=" + person.facebook + ",'instagram'=" + person.instagram + ",'twitter'=" + person.twitter + ",'youtube'=" + person.youtube + ",'sns'=" + person.sns + ",'homepage'=" + person.homepage + ",'line_id'=" + person.line_id + ",'meeting_date_str'=" + person.meeting_date_str + ",'meeting_place'=" + person.meeting_place + ",'familyname'=" + person.familyname + ",'givenname'=" + person.givenname + ",'temp1'=" + person.temp1 + ",'temp2'=" + person.temp2 + ",'temp3'=" + person.temp3 + ",'temp4'=" + person.temp4 + ",'temp5'=" + person.temp5 + ",'temp6'=" + person.temp6 + ",'temp7'=" + person.temp7 + ",'handlename'=" + person.handlename + ",'middlename'=" + person.middlename + ",'logoImageName'=" + person.logoImageName + ",'profileImageName'=" + person.profileImageName
        })
    }
    init() {
    }

}

struct BCExchangeView2_Previews: PreviewProvider {
    static var previews: some View {
        BCExchangeView2()
    }
}

