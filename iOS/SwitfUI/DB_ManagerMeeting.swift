//
//  DB_ManagerMeeting.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright 息 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
// import library
import SQLite
 
class DB_ManagerMeeting {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var meetings: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
	private var name:Expression<String>!    //  名前
	private var category:Expression<String>!    // カテゴリ
	private var meeting_date:Expression<String>!  // 名刺交換日
	private var meeting_place:Expression<String>!	// 名刺交換場所
	private var userlist:Expression<String>!	// 任意7
    private var latitude: Expression<String>!
    private var longitude: Expression<String>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/mayca_user1.sqlite3")
             
            // creating table object
            meetings = Table("meetings")
             
            // create instances of each column
            id = Expression<Int64>("id")
            name = Expression<String>("fullname")
            category = Expression<String>("category")
            meeting_date = Expression<String>("meeting_date")
            meeting_place = Expression<String>("meeting_place")
            userlist = Expression<String>("userlist")
            latitude = Expression<String>("latitude")
            longitude = Expression<String>("longitude")
             
            // check if the meeting's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_meetings_created")) {
 
                // if not, then create the table
                try db.run(meetings.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(category)
                    t.column(meeting_date)
                    t.column(meeting_place)
                    t.column(userlist)
                    t.column(latitude)
                    t.column(longitude)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_meetings_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    public func addMeeting(nameValue: String,  categoryValue: String,  meeting_dateValue: String, meeting_placeValue: String, userlistValue: String, latitudeValue: String, longitudeValue: String) {
        do {
            try db.run(meetings.insert(name <- nameValue,  category <- categoryValue,  meeting_date <- meeting_dateValue, meeting_place <- meeting_placeValue, userlist <- userlistValue, latitude <- latitudeValue, longitude <- longitudeValue))
        } catch {
            print(error.localizedDescription)
        }
    }    

    // return array of meeting models
    public func getMeetings() -> [MeetingModel] {
         
        // create empty array
        var meetingModels: [MeetingModel] = []
     
        // get all meetings in descending order
        meetings = meetings.order(id.desc)
     
        // exception handling
        do {
     
            // loop through all meetings
            for meeting in try db.prepare(meetings) {
     
                // create new model in each loop iteration
                let meetingModel: MeetingModel = MeetingModel()
     
                // set values in model from database
                meetingModel.id = meeting[id]
                meetingModel.name = meeting[name]
                meetingModel.category = meeting[category]
                meetingModel.meeting_date = meeting[meeting_date]
                meetingModel.meeting_place = meeting[meeting_place]
                meetingModel.userlist = meeting[userlist]
                meetingModel.latitude = meeting[latitude]
                meetingModel.longitude = meeting[longitude]
                // append in new array
                meetingModels.append(meetingModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return meetingModels
    }
    
    // get single meeting data
    public func getMeeting(idValue: Int64) -> MeetingModel {
     
        // create an empty object
        let meetingModel: MeetingModel = MeetingModel()
         
        // exception handling
        do {
     
            // get meeting using ID
            let meeting: AnySequence<Row> = try db.prepare(meetings.filter(id == idValue))
     
            // get row
            try meeting.forEach({ (rowValue) in
     
                // set values in model
                meetingModel.id = try rowValue.get(id)
                meetingModel.name = try rowValue.get(name)
                meetingModel.category = try rowValue.get(category)
	            meetingModel.meeting_date = try rowValue.get(meeting_date)
	            meetingModel.meeting_place = try rowValue.get(meeting_place)
	            meetingModel.userlist = try rowValue.get(userlist)
	            meetingModel.latitude = try rowValue.get(latitude)
	            meetingModel.longitude = try rowValue.get(longitude)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return meetingModel
    }

    // function to update user
    public func updateMeeting(idValue: Int64, nameValue: String,  categoryValue: String,  meeting_dateValue: String, meeting_placeValue: String, userlistValue: String, latitudeValue: String, longitudeValue: String) {
        do {
            // get user using ID
            let user: Table = meetings.filter(id == idValue)
             
            // run the update query
            try db.run(user.update(name <- nameValue,  category <- categoryValue,  meeting_date <- meeting_dateValue, meeting_place <- meeting_placeValue, userlist <- userlistValue, latitude <- latitudeValue, longitude <- longitudeValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    // function to delete user
    public func deleteMeeting(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = meetings.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}
