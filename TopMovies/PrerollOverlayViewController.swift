//
//  PrerollOverlayViewController.swift
//  MobilePlayer
//
//  Created by Baris Sencan on 09/12/2015.
//  Copyright © 2015 MovieLaLa. All rights reserved.
//

import Foundation
import MobilePlayer

class PrerollOverlayViewController: MobilePlayerOverlayViewController {

  init() {
    super.init(nibName: "PrerollOverlayViewController", bundle: nil)
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  @IBAction func visitButtonDidGetTapped() {
    guard let websiteURL = URL(string: "https://techmaster.vn/khoa-hoc/8217/lap-trinh-ios-swift") else { return }
    if #available(iOS 10.0, *) {
        UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil
        )
    } else {
        // Fallback on earlier versions
    }
    dismiss() // or mobilePlayer.play()
  }
}
