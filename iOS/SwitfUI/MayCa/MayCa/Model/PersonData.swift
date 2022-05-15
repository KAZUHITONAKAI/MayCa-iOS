import SwiftUI
import MapKit

//Hashable は自動でハッシュ値を生成してくれるプロトコルで， 
//Codable はJSONからオブジェクトを生成する際に役立つプロトコル

//Identifiable この構造体は id が識別子として自動で認識されるようになります
struct PersonData: Hashable, Codable, Identifiable {
    var id:Int	//Identifiableにするため必要になる
	var category:String	= ""// カテゴリ
	var fullname:String = ""//  名前（フル）
	var fullyomi:String = ""// フリガナ（フル）
	var company1:String = ""// 会社名1
	var company1yomi:String = ""// フリガナ
	var company2:String = ""	// 会社名2
    var department:String = ""	// 所属部署 部
    var section:String = ""	// 所属部署 課
	var role:String = ""	// 役職
	var zipcode:String = ""	// 郵便番号
	var address1:String = ""	// 住所1
	var address2:String = ""	// 住所2
	var tel:String = ""	// TEL
	var fax:String = ""	// FAX
	var email:String = ""	// E-mail
	var homepage:String = ""	// URL
	var facebook:String = ""	// facebook
	var instagram:String = ""	// instagram
	var twitter:String = ""	// twitter
	var line_id:String = ""	// LINE ID
	var youtube:String = ""	// YouTube
	var sns:String = ""	// SNS
	var meeting_date_str:String = ""  // 名刺交換日
	//var meeting_date:Date = Date()    // 名刺交換日
	var meeting_place:String = ""	// 名刺交換場所
    var latitude: String = ""
    var longitude: String = ""
	var familyname:String = ""	// 姓(family name)
	var givenname:String = ""	// 名(given name)
	var middlename:String = ""	// ミドル
	var handlename:String = ""	// ハンドル名
    var birth_date_str:String = ""  // 誕生日
	var temp1:String = ""	// 任意1
	var temp2:String = ""	// 任意2
	var temp3:String = ""	// 任意3
	var temp4:String = ""	// 任意4
	var temp5:String = ""	// 任意5
	var temp6:String = ""	// 任意6
	var temp7:String = ""	// 任意7
    var logoImageName:String = ""
    var profileImageName:String = ""

	//外部ファイルから間違って呼び出しがされないようfileprivate で隠蔽
	fileprivate var imageName: String
	var image: Image {
		ImageStore.shared.image(name: imageName)
	}

	/*
    var locationCoordinate: CLLocationCoordinate2D {
	CLLocationCoordinate2D(
	    latitude: latitude,
	    longitude: longitude)
	}
     */
}
