import SwiftUI
import MapKit

//Hashable は自動でハッシュ値を生成してくれるプロトコルで， 
//Codable はJSONからオブジェクトを生成する際に役立つプロトコル

//Identifiable この構造体は id が識別子として自動で認識されるようになります
struct MeetingData: Hashable, Codable, Identifiable {
    var id:Int	//Identifiableにするため必要になる
	var name:String = ""//  名前
	var category:String	= ""// カテゴリ
	var meeting_date:String = ""  // 名刺交換日
	var meeting_place:String = ""	// 名刺交換場所
	var userlist:String = ""	// 任意7
    var latitude: String = ""
    var longitude: String = ""
}
