//
//  AdView.swift
//  MayCa
//
//  Created by Yasunori Nagashima on 2021/08/19.
//

import SwiftUI
import GoogleMobileAds

struct AdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: kGADAdSizeBanner)
        //バナー広告向けのテスト専用広告ユニットID
        //banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        //ganasonic@gmail.com バナー広告向けの広告ユニットID
        banner.adUnitID = "ca-app-pub-6231139717845324/5297053668"  //バナー
        //banner.adUnitID = "ca-app-pub-6231139717845324/1828938138"  //ネイティブ アドバンス


        let adSize = GADAdSizeFromCGSize(CGSize(width: 340, height: 50))
        //adSize = kGADAdSizeLargeBanner
        banner.adSize = adSize

        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
}

