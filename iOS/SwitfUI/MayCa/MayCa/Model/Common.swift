//
//  Common.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/09/19.
//

import Foundation
import SwiftUI

func getQRcodeString(image: UIImage?, QrCodeString: inout String) {
    //画像を変換
    guard let img = image else { return }
    let ciImage = CIImage(image: img)!
    var message:String?
    //画像内にQRコードがあるか調べる
    let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: nil)
    let features = detector?.features(in: ciImage)
    message = ""
    for feature in features  as! [CIQRCodeFeature] {
        message! += feature.messageString!
    }
    //テキストに表示
    if(message == "") {
        //self.QrCodeString = "QRコードは検出されませんでした";
        QrCodeString = "QRコードは検出されませんでした";
    } else {
        //self.QrCodeString = message!
        //print(self.QrCodeString)
        QrCodeString = message!
        print(QrCodeString)
    }
}

func checkHaveSpace(target: String) -> Bool {
    let elem = target.components(separatedBy: " ")
    if elem.count>0 {
        return true
    }else{
        return false
    }
}

func checkProfibitSpace(userdata:UserModel) -> Int8 {
    if userdata.tel.contains(" ") || userdata.temp6.contains(" ") || userdata.fax.contains(" "){
        return 1
    }
    if userdata.email.contains(" ") {
        return 2
    }
    if userdata.homepage.contains(" ") {
        return 3
    }
    if userdata.facebook.contains(" ") || userdata.instagram.contains(" ") || userdata.twitter.contains(" ") || userdata.youtube.contains(" ") || userdata.youtube.contains(" ") {
        return 4
    }
    return 0
}

func setAlertMsg(errtype: Int8, title: inout String, message: inout String) -> Bool {
    var showingAlert = false
    //var title:String
    //var message:String
    if errtype>0 {
        showingAlert = true
    }
    if errtype == 1 {
        title = "空白エラー"
        message = "電話番号に空白は許可していません"
    }else if errtype == 2 {
        title = "空白エラー"
        message = "メアドに空白は許可していません"
    }else if errtype == 3 {
        title = "空白エラー"
        message = "URLに空白があるとLink起動できません"
    }else if errtype == 4 {
        title = "空白警告"
        message = "アカウントに空白があるとLink起動できません"
    }else if errtype == 5 {
        title = "必須項目エラー"
        message = "氏名とフリガナは必須項目です。"
    }else{
    }
    return showingAlert
}


