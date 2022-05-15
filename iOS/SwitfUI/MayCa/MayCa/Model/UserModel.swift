//
//  UserModel.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
class UserModel: Identifiable {
    public var id: Int64 = 0
    public var category:String	= ""// カテゴリ
    public var fullname:String = ""//  名前（フル）
    public var fullyomi:String = ""// フリガナ（フル）
    public var company1:String = ""// 会社名1
    public var company1yomi:String = ""// フリガナ
    public var company2:String = ""	// 会社名2
    public var department:String = ""	// 所属部署 部
    public var section:String = ""	// 所属部署 課
    public var role:String = ""	// 役職
    public var zipcode:String = ""	// 郵便番号
    public var address1:String = ""	// 住所1
    public var address2:String = ""	// 住所2
    public var tel:String = ""	// TEL
    public var fax:String = ""	// FAX
    public var email:String = ""	// E-mail
    public var homepage:String = ""	// URL
    public var facebook:String = ""	// facebook
    public var twitter:String = ""	// twitter
    public var instagram:String = ""	// instagram
    public var line_id:String = ""	// LINE ID
    public var youtube:String = ""	// YouTube
    public var sns:String = ""	// SNS
    public var meeting_date_str:String = ""  // 名刺交換日
    public var meeting_place:String = ""	// 名刺交換場所
    public var latitude: String = ""
    public var longitude: String = ""

    public var birth_date_str:String = ""  // 誕生日

    public var familyname:String = ""	// 姓(family name)
    public var givenname:String = ""	// 名(given name)
    public var middlename:String = ""	// ミドル
    public var handlename:String = ""	// ハンドル名
    public var temp1:String = ""	// 任意1
    public var temp2:String = ""	// 任意2
    public var temp3:String = ""	// 任意3
    public var temp4:String = ""	// 任意4
    public var temp5:String = ""	// 任意5
    public var temp6:String = ""	// 任意6
    public var temp7:String = ""	// 任意7

    public var logoImageName: String = ""
    public var profileImageName: String = ""
}
