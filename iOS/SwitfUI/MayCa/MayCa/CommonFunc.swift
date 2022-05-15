//
//  CommonFunc.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/06.
//

import Foundation
import MapKit // import CoreLocation でも可

class CommonFunc {
    func setQrCodeReadingData(scanedString:String){
        let userdata:UserModel = UserModel()
        let usrString:String = scanedString
        let teststr = usrString.components(separatedBy: ",")
        print(teststr)
        for i in 0..<teststr.count {
            let elem = teststr[i].components(separatedBy: "=")
            if elem.count == 2 {
                print(elem[0])
                print(elem[1])
                switch elem[0] {
                case "'category'":
                    userdata.category = elem[1]
                case "'fullname'":
                    userdata.fullname = elem[1]
                case "'fullyomi'":
                    userdata.fullyomi = elem[1]
                case "'company1'":
                    userdata.company1 = elem[1]
                case "'company2'":
                    userdata.company2 = elem[1]
                case "'department'":
                    userdata.department = elem[1]
                case "'section'":
                    userdata.section = elem[1]
                case "'role'":
                    userdata.role = elem[1]
                case "'zipcode'":
                    userdata.zipcode = elem[1]
                case "'address1'":
                    userdata.address1 = elem[1]
                case "'address2'":
                    userdata.address2 = elem[1]
                case "'tel'":
                    userdata.tel = elem[1]
                case "'fax'":
                    userdata.fax = elem[1]
                case "'email'":
                    userdata.email = elem[1]
                case "'homepage'":
                    userdata.homepage = elem[1]
                case "'facebook'":
                    userdata.facebook = elem[1]
                case "'twitter'":
                    userdata.twitter = elem[1]
                case "'instagram'":
                    userdata.instagram = elem[1]
                case "'line_id'":
                    userdata.line_id = elem[1]
                case "'youtube'":
                    userdata.youtube = elem[1]
                case "'sns'":
                    userdata.sns = elem[1]
                /*
                case "'meeting_date_str'":
                    userdata.meeting_date_str = elem[1]
                case "'meeting_place'":
                    userdata.meeting_place = elem[1]
                case "'latitude'":
                    userdata.latitude = elem[1]
                case "'longitude'":
                    userdata.longitude = elem[1]
                */
                case "'birth_date_str'":
                    userdata.birth_date_str = elem[1]
                case "'familyname'":
                    userdata.familyname = elem[1]
                case "'givenname'":
                    userdata.givenname = elem[1]
                case "'middlename'":
                    userdata.middlename = elem[1]
                case "'handlename'":
                    userdata.handlename = elem[1]
                case "'temp1'":
                    userdata.temp1 = elem[1]
                case "'temp2'":
                    userdata.temp2 = elem[1]
                case "'temp3'":
                    userdata.temp3 = elem[1]
                case "'temp4'":
                    userdata.temp4 = elem[1]
                case "'temp5'":
                    userdata.temp5 = elem[1]
                case "'temp6'":
                    userdata.temp6 = elem[1]
                case "'temp7'":
                    userdata.temp7 = elem[1]
                case "'logoImageName'":
                    userdata.logoImageName = elem[1]
                case "'profileImageName'":
                    if elem[1].count == 0 {
                        userdata.profileImageName = "avatar"
                    }else{
                        userdata.profileImageName = elem[1]
                    }
                default:
                    userdata.temp7 = elem[1]
                }
            }
        }
        //userdata = DB_Manager().getUser(idValue: g_index)
        userdata.latitude = String(location.latitude)
        userdata.longitude = String(location.longitude)
        //緯度経度から住所取得
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, error == nil else { return }
            //緯度経度から住所取得
            userdata.meeting_place = placemark.locality! + placemark.name!
        }
        
        //現在の日付
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let nowdate = Date()
        print(nowdate)
        let datestr = dateFormatter.string(from: nowdate)
        print(datestr)
        userdata.meeting_date_str = datestr

        DB_Manager().addUser(categoryValue:userdata.category, fullnameValue:userdata.fullname, fullyomiValue:userdata.fullyomi, company1Value:userdata.company1, company1yomiValue:userdata.company1yomi, company2Value:userdata.company2, departmentValue:userdata.department, sectionValue:userdata.section, roleValue:userdata.role, zipcodeValue:userdata.zipcode, address1Value:userdata.address1, address2Value:userdata.address2, telValue:userdata.tel, faxValue:userdata.fax, emailValue: userdata.email, homepageValue:userdata.homepage, facebookValue:userdata.facebook, twitterValue:userdata.twitter, instagramValue:userdata.instagram, line_idValue:userdata.line_id, youtubeValue:userdata.youtube, snsValue:userdata.sns, meeting_date_strValue:userdata.meeting_date_str, meeting_placeValue:userdata.meeting_place, latitudeValue:userdata.latitude, longitudeValue:userdata.longitude, birth_date_strValue:userdata.birth_date_str, familynameValue:userdata.familyname, givennameValue:userdata.givenname, middlenameValue:userdata.middlename, handlenameValue:userdata.handlename, temp1Value:userdata.temp1, temp2Value:userdata.temp2, temp3Value:userdata.temp3, temp4Value:userdata.temp4, temp5Value:userdata.temp5, temp6Value:userdata.temp6, temp7Value:userdata.temp7, logoImageNameValue:userdata.logoImageName, profileImageNameValue:userdata.profileImageName)

  }
}
