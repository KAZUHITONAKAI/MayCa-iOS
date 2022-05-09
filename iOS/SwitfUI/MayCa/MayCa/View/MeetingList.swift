import SwiftUI

struct MeetingList: View {
    //var meetingData: MeetingData
    @State var meetingModels: [MeetingModel] = []

    var body: some View {
        VStack {
            HStack{
                Text("カテゴリ絞り込み")
                Spacer()
                NavigationLink (destination: AddMeetingView(), label: {
                    CircleImage(image: Image("add"))
                        .padding()
                })
            }
            //
            List(meetingModels) { meetingModel in
                NavigationLink(destination: MeetingDetail(meeting: meetingModel)) {
                    MeetingRow(meetingData: meetingModel)
                }
                .navigationBarTitle(Text("会議モード"))
            }
        }
        .onAppear(perform: {
            self.meetingModels = DB_ManagerMeeting().getMeetings()
        })
    }
}

struct MeetingList_Previews: PreviewProvider {
    static var previews: some View {
        MeetingList()
    }
}
