//
//  DB_ManagerUserData.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright 息 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
// import library
import SQLite
 
class DB_ManagerUserData {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var userdatas: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var userkey: Expression<String>!
    private var uservalue: Expression<String>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/mayca_user1.sqlite3")
             
            // creating table object
            userdatas = Table("userdatas")
             
            // create instances of each column
            id = Expression<Int64>("id")
            userkey = Expression<String>("userkey")
            uservalue = Expression<String>("uservalue")
             
            // check if the userdata's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_userdata_created")) {
 
                // if not, then create the table
                try db.run(userdatas.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(userkey)
                    t.column(uservalue)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_userdata_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    public func addUserData(userkeyValue: String,  uservalueValue: String) {
        do {
            try db.run(userdatas.insert(userkey <- userkeyValue,  uservalue <- uservalueValue))
        } catch {
            print(error.localizedDescription)
        }
    }    

    // return array of userdata models
    public func getUserDatas() -> [UserDataModel] {
         
        // create empty array
        var userModels: [UserDataModel] = []
     
        // get all userdatas in descending order
        userdatas = userdatas.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all userdatas
            for userdata in try db.prepare(userdatas) {
     
                // create new model in each loop iteration
                let userModel: UserDataModel = UserDataModel()
     
                // set values in model from database
                userModel.id = userdata[id]
                userModel.userkey = userdata[userkey]
                userModel.uservalue = userdata[uservalue]
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }

    // get single userdata data
    public func getUserData(idValue: Int64) -> UserDataModel {
     
        // create an empty object
        let userModel: UserDataModel = UserDataModel()
         
        // exception handling
        do {
     
            // get userdata using ID
            let userdata: AnySequence<Row> = try db.prepare(userdatas.filter(id == idValue))
     
            // get row
            try userdata.forEach({ (rowValue) in
     
                // set values in model
                userModel.id = try rowValue.get(id)
                userModel.userkey = try rowValue.get(userkey)
                userModel.uservalue = try rowValue.get(uservalue)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return userModel
    }

    // function to update userdata
    public func updateUserData(idValue: Int64, userkeyValue: String,  uservalueValue: String) {
        do {
            // get userdata using ID
            let userdata: Table = userdatas.filter(id == idValue)
             
            // run the update query
            try db.run(userdata.update(userkey <- userkeyValue,  uservalue <- uservalueValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    // function to delete userdata
    public func deleteUserData(idValue: Int64) {
        do {
            // get userdata using ID
            let userdata: Table = userdatas.filter(id == idValue)
             
            // run the delete query
            try db.run(userdata.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}
