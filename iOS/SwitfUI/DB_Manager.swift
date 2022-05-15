//
//  DB_Manager.swift
//  SQLite_Database
//
//  Created by Adnan Afzal on 24/11/2020.
//  Copyright 息 2020 Adnan Afzal. All rights reserved.
//
 
import Foundation
 
// import library
import SQLite
 
class DB_Manager {
     
    // sqlite instance
    private var db: Connection!
     
    // table instance
    private var users: Table!
 
    // columns instances of table
    private var id: Expression<Int64>!
    private var category: Expression<String>!
    private var fullname: Expression<String>!
    private var fullyomi: Expression<String>!
    private var company1: Expression<String>!
    private var company1yomi: Expression<String>!
    private var company2: Expression<String>!
    private var department: Expression<String>!
    private var section: Expression<String>!
    private var role: Expression<String>!
    private var zipcode: Expression<String>!
    private var address1: Expression<String>!
    private var address2: Expression<String>!
    private var tel: Expression<String>!
    private var fax: Expression<String>!
    private var email: Expression<String>!
    private var homepage: Expression<String>!
    private var facebook: Expression<String>!
    private var twitter: Expression<String>!
    private var instagram: Expression<String>!
    private var line_id: Expression<String>!
    private var youtube: Expression<String>!
    private var sns: Expression<String>!
    private var meeting_date_str: Expression<String>!
    private var meeting_place: Expression<String>!
    private var latitude: Expression<String>!
    private var longitude: Expression<String>!
    private var birth_date_str: Expression<String>!
    private var familyname: Expression<String>!
    private var givenname: Expression<String>!
    private var middlename: Expression<String>!
    private var handlename: Expression<String>!
    private var temp1: Expression<String>!
    private var temp2: Expression<String>!
    private var temp3: Expression<String>!
    private var temp4: Expression<String>!
    private var temp5: Expression<String>!
    private var temp6: Expression<String>!
    private var temp7: Expression<String>!
    private var logoImageName: Expression<String>!
    private var profileImageName: Expression<String>!
     
    // constructor of this class
    init () {
         
        // exception handling
        do {
             
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
 
            // creating database connection
            db = try Connection("\(path)/mayca_user1.sqlite3")
             
            // creating table object
            users = Table("users")
             
            // create instances of each column
            id = Expression<Int64>("id")
            email = Expression<String>("email")
            category = Expression<String>("category")
            fullname = Expression<String>("fullname")
            fullyomi = Expression<String>("fullyomi")
            company1 = Expression<String>("company1")
            company1yomi = Expression<String>("company1yomi")
            company2 = Expression<String>("company2")
            department = Expression<String>("department")
            section = Expression<String>("section")
            role = Expression<String>("role")
            zipcode = Expression<String>("zipcode")
            address1 = Expression<String>("address1")
            address2 = Expression<String>("address2")
            tel = Expression<String>("tel")
            fax = Expression<String>("fax")
            homepage = Expression<String>("homepage")
            facebook = Expression<String>("facebook")
            twitter = Expression<String>("twitter")
            instagram = Expression<String>("instagram")
            line_id = Expression<String>("line_id")
            youtube = Expression<String>("youtube")
            sns = Expression<String>("sns")
            meeting_date_str = Expression<String>("meeting_date_str")
            meeting_place = Expression<String>("meeting_place")
            latitude = Expression<String>("latitude")
            longitude = Expression<String>("longitude")
            birth_date_str = Expression<String>("birth_date_str")
            familyname = Expression<String>("familyname")
            givenname = Expression<String>("givenname")
            middlename = Expression<String>("middlename")
            handlename = Expression<String>("handlename")
            temp1 = Expression<String>("temp1")
            temp2 = Expression<String>("temp2")
            temp3 = Expression<String>("temp3")
            temp4 = Expression<String>("temp4")
            temp5 = Expression<String>("temp5")
            temp6 = Expression<String>("temp6")
            temp7 = Expression<String>("temp7")
            logoImageName = Expression<String>("logoImageName")
            profileImageName = Expression<String>("profileImageName")
             
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")) {
 
                // if not, then create the table
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(category)
                    t.column(fullname)
                    t.column(fullyomi)
                    t.column(company1)
                    t.column(company1yomi)
                    t.column(company2)
                    t.column(department)
                    t.column(section)
                    t.column(role)
                    t.column(zipcode)
                    t.column(address1)
                    t.column(address2)
                    t.column(tel)
                    t.column(fax)
                    //t.column(email, unique: true)
                    t.column(email)
                    t.column(homepage)
                    t.column(facebook)
                    t.column(twitter)
                    t.column(instagram)
                    t.column(line_id)
                    t.column(youtube)
                    t.column(sns)
                    t.column(meeting_date_str)
                    t.column(meeting_place)
                    t.column(latitude)
                    t.column(longitude)
                    t.column(birth_date_str)
                    t.column(familyname)
                    t.column(givenname)
                    t.column(middlename)
                    t.column(handlename)
                    t.column(temp1)
                    t.column(temp2)
                    t.column(temp3)
                    t.column(temp4)
                    t.column(temp5)
                    t.column(temp6)
                    t.column(temp7)
                    t.column(logoImageName)
                    t.column(profileImageName)
                })
                 
                // set the value to true, so it will not attempt to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
             
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
         
    }
    
    public func addUser(categoryValue: String,  fullnameValue: String,  fullyomiValue: String,  company1Value: String,  company1yomiValue: String,  company2Value: String,  departmentValue: String,  sectionValue: String,  roleValue: String,  zipcodeValue: String,  address1Value: String,  address2Value: String,  telValue: String,  faxValue: String, emailValue: String, homepageValue: String, facebookValue: String, twitterValue: String, instagramValue: String, line_idValue: String, youtubeValue: String, snsValue: String, meeting_date_strValue: String, meeting_placeValue: String, latitudeValue: String, longitudeValue: String, birth_date_strValue: String, familynameValue: String, givennameValue: String, middlenameValue: String, handlenameValue: String, temp1Value: String, temp2Value: String, temp3Value: String, temp4Value: String, temp5Value: String, temp6Value: String, temp7Value: String, logoImageNameValue: String, profileImageNameValue: String) {
        do {
            try db.run(users.insert(category <- categoryValue,  fullname <- fullnameValue,  fullyomi <- fullyomiValue,  company1 <- company1Value,  company1yomi <- company1yomiValue,  company2 <- company2Value,  department <- departmentValue,  section <- sectionValue,  role <- roleValue,  zipcode <- zipcodeValue,  address1 <- address1Value,  address2 <- address2Value,  tel <- telValue,  fax <- faxValue, email <- emailValue, homepage <- homepageValue, facebook <- facebookValue, twitter <- twitterValue, instagram <- instagramValue, line_id <- line_idValue, youtube <- youtubeValue, sns <- snsValue, meeting_date_str <- meeting_date_strValue, meeting_place <- meeting_placeValue, latitude <- latitudeValue, longitude <- longitudeValue, birth_date_str <- birth_date_strValue, familyname <- familynameValue, givenname <- givennameValue, middlename <- middlenameValue, handlename <- handlenameValue, temp1 <- temp1Value, temp2 <- temp2Value, temp3 <- temp3Value, temp4 <- temp4Value, temp5 <- temp5Value, temp6 <- temp6Value, temp7 <- temp7Value, logoImageName <- logoImageNameValue, profileImageName <- profileImageNameValue))
        } catch {
            print(error.localizedDescription)
        }
    }    

    // return array of user models
    public func getUsers() -> [UserModel] {
         
        // create empty array
        var userModels: [UserModel] = []
     
        // get all users in descending order
        //users = users.order(id.desc)
        users = users.order(fullyomi.asc)

        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(users) {
     
                // create new model in each loop iteration
                let userModel: UserModel = UserModel()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.category = user[category]
                userModel.fullname = user[fullname]
                userModel.fullyomi = user[fullyomi]
                userModel.company1 = user[company1]
                userModel.company1yomi = user[company1yomi]
                userModel.company2 = user[company2]
                userModel.department = user[department]
                userModel.section = user[section]
                userModel.role = user[role]
                userModel.zipcode = user[zipcode]
                userModel.address1 = user[address1]
                userModel.address2 = user[address2]
                userModel.tel = user[tel]
                userModel.fax = user[fax]
                userModel.email = user[email]
                userModel.homepage = user[homepage]
                userModel.facebook = user[facebook]
                userModel.twitter = user[twitter]
                userModel.instagram = user[instagram]
                userModel.line_id = user[line_id]
                userModel.youtube = user[youtube]
                userModel.sns = user[sns]
                userModel.meeting_date_str = user[meeting_date_str]
                userModel.meeting_place = user[meeting_place]
                userModel.latitude = user[latitude]
                userModel.longitude = user[longitude]
                userModel.birth_date_str = user[birth_date_str]
                userModel.familyname = user[familyname]
                userModel.givenname = user[givenname]
                userModel.middlename = user[middlename]
                userModel.handlename = user[handlename]
                userModel.temp1 = user[temp1]
                userModel.temp2 = user[temp2]
                userModel.temp3 = user[temp3]
                userModel.temp4 = user[temp4]
                userModel.temp5 = user[temp5]
                userModel.temp6 = user[temp6]
                userModel.temp7 = user[temp7]
                userModel.logoImageName = user[logoImageName]
                userModel.profileImageName = user[profileImageName]
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }

    // return array of user models
    public func getUsersSameMeeting(meeting_date: String) -> [UserModel] {
         
        // create empty array
        var userModels: [UserModel] = []
     
        // get all users in descending order
        //users = users.order(id.desc).filter(meeting_date == meeting_date_str)
        users = users.order(fullyomi.asc).filter(meeting_date == meeting_date_str)

        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(users) {
     
                // create new model in each loop iteration
                let userModel: UserModel = UserModel()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.category = user[category]
                userModel.fullname = user[fullname]
                userModel.fullyomi = user[fullyomi]
                userModel.company1 = user[company1]
                userModel.company1yomi = user[company1yomi]
                userModel.company2 = user[company2]
                userModel.department = user[department]
                userModel.section = user[section]
                userModel.role = user[role]
                userModel.zipcode = user[zipcode]
                userModel.address1 = user[address1]
                userModel.address2 = user[address2]
                userModel.tel = user[tel]
                userModel.fax = user[fax]
                userModel.email = user[email]
                userModel.homepage = user[homepage]
                userModel.facebook = user[facebook]
                userModel.twitter = user[twitter]
                userModel.instagram = user[instagram]
                userModel.line_id = user[line_id]
                userModel.youtube = user[youtube]
                userModel.sns = user[sns]
                userModel.meeting_date_str = user[meeting_date_str]
                userModel.meeting_place = user[meeting_place]
                userModel.latitude = user[latitude]
                userModel.longitude = user[longitude]
                userModel.birth_date_str = user[birth_date_str]
                userModel.familyname = user[familyname]
                userModel.givenname = user[givenname]
                userModel.middlename = user[middlename]
                userModel.handlename = user[handlename]
                userModel.temp1 = user[temp1]
                userModel.temp2 = user[temp2]
                userModel.temp3 = user[temp3]
                userModel.temp4 = user[temp4]
                userModel.temp5 = user[temp5]
                userModel.temp6 = user[temp6]
                userModel.temp7 = user[temp7]
                userModel.logoImageName = user[logoImageName]
                userModel.profileImageName = user[profileImageName]
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        // return array
        return userModels
    }

    // return array of user models
    public func getUsersByCategory(selected_category: String) -> [UserModel] {
         
        // create empty array
        var userModels: [UserModel] = []
     
        // get all users in descending order
        if selected_category == "All" {
            //users = users.order(id.desc)
            users = users.order(fullyomi.asc)
            
        }else{
            //users = users.order(id.desc).filter(selected_category == category)
            users = users.order(fullyomi.asc).filter(selected_category == category)
        }

        print("category: \(selected_category)")
     
        // exception handling
        do {
     
            // loop through all users
            for user in try db.prepare(users) {
     
                // create new model in each loop iteration
                let userModel: UserModel = UserModel()
     
                // set values in model from database
                userModel.id = user[id]
                userModel.category = user[category]
                userModel.fullname = user[fullname]
                userModel.fullyomi = user[fullyomi]
                userModel.company1 = user[company1]
                userModel.company1yomi = user[company1yomi]
                userModel.company2 = user[company2]
                userModel.department = user[department]
                userModel.section = user[section]
                userModel.role = user[role]
                userModel.zipcode = user[zipcode]
                userModel.address1 = user[address1]
                userModel.address2 = user[address2]
                userModel.tel = user[tel]
                userModel.fax = user[fax]
                userModel.email = user[email]
                userModel.homepage = user[homepage]
                userModel.facebook = user[facebook]
                userModel.twitter = user[twitter]
                userModel.instagram = user[instagram]
                userModel.line_id = user[line_id]
                userModel.youtube = user[youtube]
                userModel.sns = user[sns]
                userModel.meeting_date_str = user[meeting_date_str]
                userModel.meeting_place = user[meeting_place]
                userModel.latitude = user[latitude]
                userModel.longitude = user[longitude]
                userModel.birth_date_str = user[birth_date_str]
                userModel.familyname = user[familyname]
                userModel.givenname = user[givenname]
                userModel.middlename = user[middlename]
                userModel.handlename = user[handlename]
                userModel.temp1 = user[temp1]
                userModel.temp2 = user[temp2]
                userModel.temp3 = user[temp3]
                userModel.temp4 = user[temp4]
                userModel.temp5 = user[temp5]
                userModel.temp6 = user[temp6]
                userModel.temp7 = user[temp7]
                userModel.logoImageName = user[logoImageName]
                userModel.profileImageName = user[profileImageName]
                // append in new array
                userModels.append(userModel)
            }
        } catch {
            print(error.localizedDescription)
        }
     
        print("count: \(userModels.count)")
        // return array
        return userModels
    }

    // get single user data
    public func getUser(idValue: Int64) -> UserModel {
     
        // create an empty object
        let userModel: UserModel = UserModel()
         
        // exception handling
        do {
     
            // get user using ID
            let user: AnySequence<Row> = try db.prepare(users.filter(id == idValue))
     
            // get row
            try user.forEach({ (rowValue) in
     
                // set values in model
                userModel.id = try rowValue.get(id)
                userModel.category = try rowValue.get(category)
                userModel.fullname = try rowValue.get(fullname)
                userModel.fullyomi = try rowValue.get(fullyomi)
                userModel.company1 = try rowValue.get(company1)
                userModel.company1yomi = try rowValue.get(company1yomi)
                userModel.company2 = try rowValue.get(company2)
                userModel.department = try rowValue.get(department)
                userModel.section = try rowValue.get(section)
                userModel.role = try rowValue.get(role)
                userModel.zipcode = try rowValue.get(zipcode)
                userModel.address1 = try rowValue.get(address1)
                userModel.address2 = try rowValue.get(address2)
                userModel.tel = try rowValue.get(tel)
                userModel.fax = try rowValue.get(fax)
                userModel.email = try rowValue.get(email)
	            userModel.homepage = try rowValue.get(homepage)
	            userModel.facebook = try rowValue.get(facebook)
	            userModel.twitter = try rowValue.get(twitter)
	            userModel.instagram = try rowValue.get(instagram)
	            userModel.line_id = try rowValue.get(line_id)
	            userModel.youtube = try rowValue.get(youtube)
	            userModel.sns = try rowValue.get(sns)
	            userModel.meeting_date_str = try rowValue.get(meeting_date_str)
	            userModel.meeting_place = try rowValue.get(meeting_place)
	            userModel.latitude = try rowValue.get(latitude)
	            userModel.longitude = try rowValue.get(longitude)
	            userModel.birth_date_str = try rowValue.get(birth_date_str)
	            userModel.familyname = try rowValue.get(familyname)
	            userModel.givenname = try rowValue.get(givenname)
	            userModel.middlename = try rowValue.get(middlename)
	            userModel.handlename = try rowValue.get(handlename)
	            userModel.temp1 = try rowValue.get(temp1)
	            userModel.temp2 = try rowValue.get(temp2)
	            userModel.temp3 = try rowValue.get(temp3)
	            userModel.temp4 = try rowValue.get(temp4)
	            userModel.temp5 = try rowValue.get(temp5)
	            userModel.temp6 = try rowValue.get(temp6)
	            userModel.temp7 = try rowValue.get(temp7)
	            userModel.logoImageName = try rowValue.get(logoImageName)
	            userModel.profileImageName = try rowValue.get(profileImageName)
            })
        } catch {
            print(error.localizedDescription)
        }
     
        // return model
        return userModel
    }

    // function to update user
    public func updateUser(idValue: Int64, categoryValue: String,  fullnameValue: String,  fullyomiValue: String,  company1Value: String,  company1yomiValue: String,  company2Value: String,  departmentValue: String,  sectionValue: String,  roleValue: String,  zipcodeValue: String,  address1Value: String,  address2Value: String,  telValue: String,  faxValue: String, emailValue: String, homepageValue: String, facebookValue: String, twitterValue: String, instagramValue: String, line_idValue: String, youtubeValue: String, snsValue: String, meeting_date_strValue: String, meeting_placeValue: String, latitudeValue: String, longitudeValue: String, birth_date_strValue: String, familynameValue: String, givennameValue: String, middlenameValue: String, handlenameValue: String, temp1Value: String, temp2Value: String, temp3Value: String, temp4Value: String, temp5Value: String, temp6Value: String, temp7Value: String, logoImageNameValue: String, profileImageNameValue: String) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
             
            // run the update query
            try db.run(user.update(category <- categoryValue,  fullname <- fullnameValue,  fullyomi <- fullyomiValue,  company1 <- company1Value,  company1yomi <- company1yomiValue,  company2 <- company2Value,  department <- departmentValue,  section <- sectionValue,  role <- roleValue,  zipcode <- zipcodeValue,  address1 <- address1Value,  address2 <- address2Value,  tel <- telValue,  fax <- faxValue, email <- emailValue, homepage <- homepageValue, facebook <- facebookValue, twitter <- twitterValue, instagram <- instagramValue, line_id <- line_idValue, youtube <- youtubeValue, sns <- snsValue, meeting_date_str <- meeting_date_strValue, meeting_place <- meeting_placeValue, latitude <- latitudeValue, longitude <- longitudeValue, birth_date_str <- birth_date_strValue, familyname <- familynameValue, givenname <- givennameValue, middlename <- middlenameValue, handlename <- handlenameValue, temp1 <- temp1Value, temp2 <- temp2Value, temp3 <- temp3Value, temp4 <- temp4Value, temp5 <- temp5Value, temp6 <- temp6Value, temp7 <- temp7Value, logoImageName <- logoImageNameValue, profileImageName <- profileImageNameValue))
        } catch {
            print(error.localizedDescription)
        }
    }

    // function to delete user
    public func deleteUser(idValue: Int64) {
        do {
            // get user using ID
            let user: Table = users.filter(id == idValue)
             
            // run the delete query
            try db.run(user.delete())
        } catch {
            print(error.localizedDescription)
        }
    }
}
