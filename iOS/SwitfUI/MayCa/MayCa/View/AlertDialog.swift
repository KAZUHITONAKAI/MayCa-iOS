//
//  AlertDialog.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/07/17.
//

import Foundation
import EMAlertController
import SwiftUI

class AlertDialog{

    static func showAlert(title:String, message:String, buttonTitle:String, view: UIView){
        let alert = EMAlertController(title: title, message: message)
        let close = EMAlertAction(title: buttonTitle, style: .cancel)
        
        alert.cornerRadius = 10.0
        alert.iconImage = UIImage(named: "ok")
        alert.addAction(close)
        //view.present(alert, animated: true, completion: nil)
    }
    
}
