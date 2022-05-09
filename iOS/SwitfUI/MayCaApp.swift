//
//  MayCaApp.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/04/19.
//

import SwiftUI
import CoreLocation //CoreLocationを利用
import Firebase
import GoogleMobileAds
//import FirebaseUI

var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(36, 135)
var screen_info: CGSize!

@main
struct MayCaApp: App {
    //AppDelegateを設定できるようにする
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// アプリの起動時に、位置情報を利用できるように設定してしまう
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate{
    var locationManager : CLLocationManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        locationManager = CLLocationManager()
        locationManager!.delegate = self
/*
        locationManager!.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager!.desiredAccuracy = kCLLocationAccuracyThreeKilometers //精度３km（かなり低め に設定している）
            locationManager!.distanceFilter = 10
            locationManager!.allowsBackgroundLocationUpdates = true //バックグラウンド処理を可能にする
            locationManager!.pausesLocationUpdatesAutomatically = false //ポーズしても位置取得を続ける
            locationManager!.startUpdatingLocation()
        }
*/
        locationManager!.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.distanceFilter = 10
            locationManager!.activityType = .fitness
            locationManager!.startUpdatingLocation()
        }

        GADMobileAds.sharedInstance().start(completionHandler: nil)
        /*
        FirebaseApp.configure()
        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        authUI.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth(),
            FUIFacebookAuth(),
            FUITwitterAuth(),
            FUIOAuth.appleAuthProvider(),
            FUIPhoneAuth(authUI:FUIAuth.defaultAuthUI()),
        ]
        self.authUI.providers = providers
 */
        screen_info = UIScreen.main.bounds.size

        return true
    }

    //位置情報に変化があった場合の処理（今回は単純に緯度と軽度を出力する）
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let newLocation = locations.last else {
            return
        }

        location = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude)
        //print("緯度: ", location.latitude, "経度: ", location.longitude)
    }
}
