//
//  UserModel.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
class UserSettingModel {
    public var category	= false// カテゴリ
    public var fullname = false//  名前（フル）
    public var fullyomi = false// フリガナ（フル）
    public var company1 = false// 会社名1
    public var company1yomi = false// フリガナ
    public var company2 = false	// 会社名2
    public var department = false	// 所属部署 部
    public var section = false	// 所属部署 課
    public var role = false	// 役職
    public var zipcode = false	// 郵便番号
    public var address1 = false	// 住所1
    public var address2 = false	// 住所2
    public var tel = false	// TEL
    public var fax = false	// FAX
    public var email = false	// E-mail
    public var homepage = false	// URL
    public var facebook = false	// facebook
    public var twitter = false	// twitter
    public var instagram = false	// instagram
    public var line_id = false	// LINE ID
    public var youtube = false	// YouTube
    public var sns = false	// SNS
    public var meeting_date = false  // 名刺交換日
    public var meeting_place = false	// 名刺交換場所
    public var latitude = false
    public var longitude = false

    public var birth_date = false  // 誕生日

    public var familyname = false	// 姓(family name)
    public var givenname = false	// 名(given name)
    public var middlename = false	// ミドル
    public var handlename = false	// ハンドル名
    public var temp1 = false	// 任意1
    public var temp2 = false	// 任意2
    public var temp3 = false	// 任意3
    public var temp4 = false	// 任意4
    public var temp5 = false	// 任意5
    public var temp6 = false	// 任意6
    public var temp7 = false	// 任意7

    public var logoImageName = false
    public var profileImageName = false
}
