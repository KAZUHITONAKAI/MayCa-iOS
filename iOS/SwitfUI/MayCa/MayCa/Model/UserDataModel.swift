//
//  UserDataModel.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright © 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
class UserDataModel: Identifiable {
    public var id: Int64 = 0
    public var userkey:String	= ""// キー
    public var uservalue:String = ""//  値
}
