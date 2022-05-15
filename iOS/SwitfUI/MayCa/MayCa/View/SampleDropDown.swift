import SwiftUI


struct SampleDropDown: View {
    
  
    let action : (String?) -> Void
    
    var body: some View {
        
        
        VStack(alignment: .leading, spacing: 4){
            
            ForEach(0...3, id: \.self){ valueStore in
                
                Button(action: {
                    
                    
                    
                }) {
                    
                    HStack(alignment: .center, spacing: 8) {
                        
                        Image(systemName: "bell")
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                            .clipShape(Circle())
                        
                        VStack (alignment: .leading){
                            Text("ANDROID" )
                                .font(.custom(Constants.FONT_REGULAR, size: 14))
                                .foregroundColor(Color.fromHex(Colors.TEXT_COLOR_PRIMARY))
                                .padding([.leading, .top], 4)
                            
                            Text("#jetpack")
                                .font(.custom(Constants.FONT_REGULAR, size: 12))
                                .foregroundColor(Color.fromHex(Colors.LIGHT_GREY))
                                .padding([.leading, .bottom], 2)
                            
                        }
                        
                        
                    }.foregroundColor(Color.fromHex(Colors.LIGHT_GREY))
                    
                }.frame(width: .none, height: .none, alignment: .center)
                
                
                Divider().background(Color.fromHex(Colors.DIVIDOR))
                
            }
            
        }.padding(.all, 12)
        .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.white).shadow(radius: 2))
        
    }
}

struct SampleDropDown_Previews: PreviewProvider {

    static var previews: some View {
        SampleDropDown(action: {data in}).padding()
    }
}