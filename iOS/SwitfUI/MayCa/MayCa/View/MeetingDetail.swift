import SwiftUI

struct MeetingDetail: View {
    //var meeting: MeetingData
    @State var meeting:MeetingModel
    @State var position: CGSize = CGSize(width: 10, height: 80)
    @State var textOffset: CGSize = CGSize.zero
    @State var userModels: [UserModel] = []
    @State var showingPopUp = false
    // to go back on the home screen when the user is added
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>

    @State private var isPressed = false
    @GestureState private var longPressTap = false
    @GestureState private var dragOffset = CGSize.zero
    @GestureState private var dragState = DragState.inactive

    enum DragState {
        case inactive
        case pressing
        case dragging(translation: CGSize)
     
        var translation: CGSize {
            switch self {
            case .inactive, .pressing:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
     
        var isPressing: Bool {
            switch self {
            case .pressing, .dragging:
                return true
            case .inactive:
                return false
            }
        }
    }
    

    var body: some View {
        ZStack{
            VStack {
                ScrollView{
                    VStack {
                        HStack {
                            //名刺交換
                            Button(action: {
                                withAnimation {
                                    showingPopUp = true
                                }
                                //self.isActiveBCExchangeView.toggle()
                                print("Show QR Code Reader")
                            }) {
                                Image("mayca80")/*.frame(width: 40, height: 40).padding()*/
                            }
                            .padding()
                            Spacer()
                            //保存
                            NavigationLink(destination: EmptyView()) {
                                Button(action: {
                                    /*
                                    DB_ManagerMeeting().addMeeting(nameValue:self.name, categoryValue:self.category, meeting_dateValue:self.meeting_date, meeting_placeValue:self.meeting_place, userlistValue:self.userlist, latitudeValue:self.latitude, longitudeValue:self.longitude)
                                    */
                                    // go back to home page
                                    self.mode.wrappedValue.dismiss()
                                    print("save")
                                }) {
                                    CircleImage(image: Image("save"))
                                }
                            }
                        }

                        Spacer()
                        Group{
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .frame(width: 340, height: 340, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding()

                                Image("kazu")
                                    .font(.system(size: 100))
                                    .opacity(dragState.isPressing ? 0.5 : 1.0)
                                    .offset(x: position.width + dragState.translation.width, y: position.height + dragState.translation.height)
                                    .animation(.easeInOut)
                                    .foregroundColor(.green)
                                    .gesture(
                                        LongPressGesture(minimumDuration: 1.0)
                                        .sequenced(before: DragGesture())
                                        .updating($dragState, body: { (value, state, transaction) in
                         
                                            switch value {
                                            case .first(true):
                                                state = .pressing
                                            case .second(true, let drag):
                                                state = .dragging(translation: drag?.translation ?? .zero)
                                            default:
                                                break
                                            }
                         
                                        })
                                        .onEnded({ (value) in
                         
                                            guard case .second(true, let drag?) = value else {
                                                return
                                            }
                         
                                            self.position.height += drag.translation.height
                                            self.position.width += drag.translation.width
                                        })
                                    )

                                HStack {
                                    ForEach(self.userModels) { userdata in
                                        Avater(Name: userdata.fullname, color: Color.blue, linewidth: 2)
                                            .offset(x: position.width + dragOffset.width, y: position.height + dragOffset.height)
                                            .gesture(DragGesture()
                                                .updating($dragOffset, body: { (value, state, transaction) in
                             
                                                    state = value.translation
                                                })
                                                .onEnded { gesture in
                                                    self.position.height += gesture.translation.height
                                                    self.position.width += gesture.translation.width
                                                    print("start loc x : \(gesture.startLocation.x)  y : \(gesture.startLocation.y)")
                                                    print("onEnded   x : \(self.position.width)  y : \(self.position.height)")
                                                })
                                        .padding()
                                    }
                                }
                            }
                            MapView(latitude: meeting.latitude,longitude: meeting.longitude)
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 200)

                            HStack {
                                Text("会議名:")
                                    .font(.callout)
                                    .bold()
                                TextField("会議名", text: $meeting.name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            HStack {
                                Text("カテゴリ:")
                                    .font(.callout)
                                    .bold()
                                TextField("カテゴリ", text: $meeting.category)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }

                            HStack {
                                Text("名刺交換日:")
                                    .font(.callout)
                                    .bold()
                                TextField("名刺交換日", text: $meeting.meeting_date)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("名刺交換場所:")
                                    .font(.callout)
                                    .bold()
                                TextField("名刺交換場所", text: $meeting.meeting_place)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("名刺交換緯度:")
                                    .font(.callout)
                                    .bold()
                                TextField("名刺交換緯度", text: $meeting.latitude)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む

                            }
                            //.padding()
                            HStack {
                                Text("名刺交換経度:")
                                    .font(.callout)
                                    .bold()
                                TextField("名刺交換経度", text: $meeting.longitude)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む

                            }
                            //.padding()
                    }//Group
                }//ScrollView
            }//VStack
            if showingPopUp {
                PopupQRCodeReaderView(isPresent: $showingPopUp)
            }
        }//ZStack
        }.onAppear(perform: {
            reload(meeting_date: meeting.meeting_date)
        })
        .navigationBarTitle(meeting.name /*+ "(" + meeting.meeting_date + ")"*/)
    }
    
    func reload(meeting_date: String) {
        self.userModels = DB_Manager().getUsersSameMeeting(meeting_date: meeting_date)
    }
}

/*
struct MeetingDetail_Previews: PreviewProvider {
    static var previews: some View {
        MeetingDetail(meeting: meetingData[0])
    }
}
*/
