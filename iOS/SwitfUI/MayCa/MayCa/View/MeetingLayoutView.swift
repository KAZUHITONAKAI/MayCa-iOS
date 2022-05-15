import SwiftUI
 
struct MeetingLayoutView: View {
 
    @State var position: CGSize = CGSize(width: 200, height: 64)
    @State var position2: CGSize = CGSize(width: 200, height: 250)

    var drag: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        
    }
    
    var desk: some Gesture {
        DragGesture()
        .onChanged{ value in
            self.position2 = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        .onEnded{ value in
            self.position2 = CGSize(
                width: value.startLocation.x
                    + value.translation.width,
                height: value.startLocation.y
                    + value.translation.height
            )
        }
        
    }
    
    var body: some View {
 
        VStack {
            HStack{
                Text("x: \(position2.width)").font(.caption)
                Text("y: \(position2.height)").font(.caption)
            }
            HStack{
                Text("x: \(position.width)").font(.caption)
                Text("y: \(position.height)").font(.caption)
            }
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.orange)
                .frame(width: 280, height: 70, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(color: .red, radius: 2, x:2, y:2  )
                .position(x: position2.width, y: position2.height)
                .gesture(desk)

            Image("kazu")
                .position(x: position.width, y: position.height)
                .gesture(drag)
            
            HStack{
                //卓縦
                Button(action: {
                    //self.isActiveBCExchangeView.toggle()
                    print("")
                }) {
                    Text("縦")
                        .font(.caption)
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .background(Color.white)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
                //卓横
                Button(action: {
                    //self.isActiveBCExchangeView.toggle()
                    print("")
                }) {
                    Text("横")
                        .font(.caption)
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .background(Color.white)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
                //リセット
                Button(action: {
                    //self.isActiveBCExchangeView.toggle()
                    print("")
                }) {
                    Text("clear")
                        .font(.caption2)
                        .frame(width: 30, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .accentColor(.black)
                .background(Color.white)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
                //保存
                Button(action: {
                    //self.isActiveBCExchangeView.toggle()
                    print("")
                }) {
                    Text("保存")
                        .font(.caption2)
                        .frame(width: 24, height: 24, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                .padding()
                .accentColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                .background(Color.white)
                .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 2, x:0, y:2  )
            }
        }
    }
}
 
struct MeetingLayoutView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingLayoutView()
    }
}
