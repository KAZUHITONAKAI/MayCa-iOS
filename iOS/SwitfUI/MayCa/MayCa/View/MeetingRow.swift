import SwiftUI

struct MeetingRow: View {
    //var meetingData: MeetingData
    @State var meetingData:MeetingModel

    var body: some View {
        HStack{
            Text(meetingData.meeting_date)
                .font(.title3)
            VStack{
                Text(meetingData.name)
                    .font(.system(size: 16))
                Text(meetingData.category)
                    .font(.system(size: 12))
            }
        }
    }
}
/*
struct MeetingRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MeetingRow(meetingData: meetingData[0])
            MeetingRow(meetingData: meetingData[1])
            MeetingRow(meetingData: meetingData[2])
        }
        .previewLayout(.fixed(width: 300, height: 70))
	/*
	.previewLayout(...) は View オブジェクトであれば
	適用可能であり， Group { } もその一つなので
	上記のようにまとめることができます
	*/
    }
}
 */
