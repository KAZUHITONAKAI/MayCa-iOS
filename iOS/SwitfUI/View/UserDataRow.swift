import SwiftUI

struct UserDataRow: View {
    //var person: UserModel
    @State var userdata:UserModel
    var text_width_in:CGFloat = 290
    @State var profile_image:UIImage?

    var body: some View {
        HStack{
            ZStack{
                if profile_image != nil && userdata.id == 1 {
                    Image(uiImage: profile_image!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }else{
                    Image(userdata.profileImageName)
                        .resizable()
                        .frame(width: 50, height: 50)
                }
                if userdata.id == 1 {
                    Image("star")
                        .resizable()
                        .frame(width: 50, height: 50)
                }
            }
            VStack{
                if userdata.id == 1 {
                    Text(userdata.fullname)
                        .font(.system(size: 16))
                        .foregroundColor(.blue)
                        .frame(width: self.text_width_in, alignment: .leading)
                    HStack{
                        Text(userdata.company1)
                            .font(.system(size: 12))
                            .foregroundColor(.blue)
                            .frame(width: (self.text_width_in-50)*2/3, alignment: .leading)
                        Text(userdata.meeting_date_str)
                            .font(.system(size: 10))
                            .foregroundColor(.blue)
                            .frame(width: (self.text_width_in-50)*1/3, alignment: .trailing)
                    }.frame(width: self.text_width_in, alignment: .leading)
                }else{
                    Text(userdata.fullname)
                        .font(.system(size: 16))
                        .frame(width: self.text_width_in, alignment: .leading)
                    HStack{
                        Text(userdata.company1)
                            .font(.system(size: 12))
                            .frame(width: (self.text_width_in-50)*2/3, alignment: .leading)
                        Text(userdata.meeting_date_str)
                            .font(.system(size: 10))
                            .frame(width: (self.text_width_in-50)*1/3, alignment: .trailing)
                    }.frame(width: self.text_width_in, alignment: .leading)
                }

            }
        }.onAppear(perform: {
            //顔写真データのロード
            let profile_path:String = UserDefaults.standard.string(forKey: "avater") ?? "avater"
            print("path:\(profile_path)")
            profile_image = loadImageFromPath(path: profile_path)
            if profile_image == nil {
                print("profile_image :\(profile_image)")
            }else{
                print("profile_image画像取得できたよ")
            }
        })
        
    }
}

struct UserDataRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            //UserDataRow()
        }
        .previewLayout(.fixed(width: 300, height: 70))
	/*
	.previewLayout(...) は View オブジェクトであれば
	適用可能であり， Group { } もその一つなので
	上記のようにまとめることができます
	*/
    }
}
