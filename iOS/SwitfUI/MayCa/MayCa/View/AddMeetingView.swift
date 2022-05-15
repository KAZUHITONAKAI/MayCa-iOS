//
//  AddMeetingView.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import SwiftUI
import MapKit // import CoreLocation でも可

struct AddMeetingView: View {
    @State var showingPopUp = false
    // create variables to store user input values
    @State var name: String = ""
    @State var category: String = ""
    @State var meeting_date: String = ""
    @State var meeting_place: String = ""
    @State var userlist: String = ""
    @State var latitude: String = ""
    @State var longitude: String = ""
    @State var isActiveBCExchangeView = false
    @State var userModels: [UserModel] = []
    @State var position: CGSize = CGSize(width: 10 /*200*/, height: -50 /*64*/)
    //@State var textOffset: CGSize = CGSize(width: 200, height: 200/*-150*/)
    @State var textOffset: CGSize = CGSize.zero
    @State var avaters: [Avater] = []
    @State var total:Int = 2

    private var index:Int64 = 0
    @State var indexjson: Int = 1

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
                        }

                        Group{
                            HStack {
                                Text("会議名:")
                                    .font(.callout)
                                    .bold()
                                TextField("会議名", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            HStack {
                                Text("会議カテゴリ:")
                                    .font(.callout)
                                    .bold()
                                TextField("会議カテゴリ", text: $category)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            .padding()
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(Color.white)
                                    .frame(width: 340, height: 340, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .padding()

                                //テスト
                                /*
                                DraggableView(){
                                    ForEach(self.userModels) { userdata in
                                        HStack {
                                            Text(userdata.fullname)
                                                .border(Color.blue, width: 2)
                                        }
                                    }
                                }*/
                                //
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
                                        /*
                                        Text(userdata.fullname)
                                            .border(Color.blue, width: 2)
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
                                        */
                                        .padding()
                                    }
                                }
                                /*
                                VStack {
                                    ForEach(0..<self.userModels.count) { idx in
                                        Text(self.avaters[idx].Name).tag(index)
                                            .border(Color.blue, width: 2)
                                            .offset(x: self.avaters[idx].width + dragOffset.width, y: self.avaters[idx].height + dragOffset.height)
                                            .gesture(DragGesture()
                                                .updating($dragOffset, body: { (value, state, transaction) in
                                                    state = value.translation
                                                })
                                                .onEnded { gesture in
                                                    self.avaters[idx].height += gesture.translation.height
                                                    self.avaters[idx].width += gesture.translation.width
                                                    print("start loc x : \(gesture.startLocation.x)  y : \(gesture.startLocation.y)")
                                                    print("onEnded   x : \(self.position.width)  y : \(self.position.height)")
                                                })
                                    }
                                }*/
                            }
                            /*
                            ForEach (0 ..< self.total) { index in
                                Text(self.avaters[index].Name)
                                    .border(Color.blue, width: 2)
                                    .offset(x: self.avaters[index].width + dragOffset.width, y: self.avaters[index].height + dragOffset.height)
                                    .gesture(DragGesture()
                                        .updating($dragOffset, body: { (value, state, transaction) in
                                            state = value.translation
                                        })
                                        .onEnded { gesture in
                                            self.avaters[index].height += gesture.translation.height
                                            self.avaters[index].width += gesture.translation.width
                                            print("start loc x : \(gesture.startLocation.x)  y : \(gesture.startLocation.y)")
                                            print("onEnded   x : \(self.position.width)  y : \(self.position.height)")
                                        })
                            }*/
                            MapView(latitude: latitude,longitude: longitude)
                                .edgesIgnoringSafeArea(.top)
                                .frame(height: 200)

                            HStack {
                                Text("名刺交換日:")
                                    .font(.callout)
                                    .bold()
                            TextField("名刺交換日", text: $meeting_date)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("名刺交換場所:")
                                    .font(.callout)
                                    .bold()
                            TextField("名刺交換場所", text: $meeting_place)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む
                            }
                            //.padding()
                            HStack {
                                Text("名刺交換緯度:")
                                    .font(.callout)
                                    .bold()
                            TextField("名刺交換緯度", text: $latitude)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む

                            }
                            //.padding()
                            HStack {
                                Text("名刺交換経度:")
                                    .font(.callout)
                                    .bold()
                            TextField("名刺交換経度", text: $longitude)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 入力域のまわりを枠で囲む

                            }
                            //.padding()
                        }//Group
                         
                        HStack {
                            Spacer()
                            //保存
                            NavigationLink(destination: EmptyView()) {
                                Button(action: {
                                    DB_ManagerMeeting().addMeeting(nameValue:self.name, categoryValue:self.category, meeting_dateValue:self.meeting_date, meeting_placeValue:self.meeting_place, userlistValue:self.userlist, latitudeValue:self.latitude, longitudeValue:self.longitude)

                                    // go back to home page
                                    self.mode.wrappedValue.dismiss()
                                    print("save")
                                }) {
                                    CircleImage(image: Image("save"))
                                }
                            }
                        }

                        /*
                        HStack{
                            Stepper(value: $indexjson, in: 0...3) {
                                Text("\(indexjson, specifier: "%d") 番目")
                            }
                            Button(action: {
                                let index:Int = indexjson
                                name = meetingData[index].name
                                category = meetingData[index].category
                                meeting_date = meetingData[index].meeting_date
                                meeting_place = meetingData[index].meeting_place
                                userlist = meetingData[index].userlist
                                latitude = meetingData[index].latitude
                                longitude = meetingData[index].longitude
                            }, label: {
                                Text("json").font(.system(size: 12))
                            })
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.top, 10)
                                .padding(.bottom, 10)
                        }*/
                        
                        //名刺交換
                        NavigationLink(
                            destination:BCExchangeView2(),
                            isActive:$isActiveBCExchangeView
                        ) {
                            EmptyView()
                        }

                    }.padding()
                    .navigationBarTitle("新規会議").font(.system(size: 18))
                }//ScrollView
            }//VStack
            if showingPopUp {
                PopupQRCodeReaderView(isPresent: $showingPopUp)
            }
        }
        .onAppear(perform: {
            latitude = String(location.latitude)
            longitude = String(location.longitude)
            let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                guard let placemark = placemarks?.first, error == nil else { return }
                //緯度経度から住所取得
                meeting_place = placemark.locality! + placemark.name!
            }
            let date = Date()
            print(date)
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "ja_JP")
            dateFormatter.dateStyle = .medium
            dateFormatter.dateFormat = "yyyy/MM/dd"
            let datestr = dateFormatter.string(from: date)
            print(datestr)
            meeting_date = datestr
            reload(meeting_date: meeting_date)
        })
    }
    
    func reload(meeting_date: String) {
        self.userModels = DB_Manager().getUsersSameMeeting(meeting_date: meeting_date)
        for i in 0..<self.userModels.count {
            let avater = Avater()
            avater.Name = self.userModels[i].fullname
            self.avaters.append(avater)
            self.total = i+1
        }
        print("total: \(total)")
    }
}
