//
//  VponAdmobBannerViewController.swift
//  VponAdmobSampleSwift
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit
import GoogleMobileAds

class VponAdmobBannerViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var loadBannerView: UIView!
    
    var gadBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Admob - Banner"
        requestButtonDidTouch(requestButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        if gadBannerView != nil {
            gadBannerView.removeFromSuperview()
        }
        
        let request = GADRequest()
//        request.testDevices = [kGADSimulatorID]
        
        gadBannerView = GADBannerView.init(adSize: kGADAdSizeSmartBannerPortrait)
        // TODO: set ad unit id
        gadBannerView.adUnitID = ""
        gadBannerView.delegate = self
        gadBannerView.rootViewController = self
        gadBannerView.load(request)
    }
    
}

extension VponAdmobBannerViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Received banner ad successfully")
        self.loadBannerView.addSubview(bannerView)
        self.requestButton.isEnabled = true
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive banner with error: \(error.localizedFailureReason!))")
        self.requestButton.isEnabled = true
    }
    
}
