//
//  MeetingModel.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
class MeetingModel: Identifiable {
    public var id: Int64 = 0
    public var name: String = ""
    public var category:String	= ""// カテゴリ
    public var meeting_date:String = ""  // 名刺交換日
    public var meeting_place:String = ""	// 名刺交換場所
    public var userlist: String = ""
    public var latitude: String = ""
    public var longitude: String = ""
}
