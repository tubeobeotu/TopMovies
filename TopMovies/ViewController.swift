//
//  ViewController.swift
//  TopMovies
//
//  Created by Tuuu on 9/19/16.
//  Copyright © 2016 Tuuu. All rights reserved.
//

import UIKit
import MobilePlayer
class ViewController: UIViewController {
    let codeImageView = UIImageView(frame: CGRect.zero)
    let videoURL = URL(string: "http://mv1.mp3.zdn.vn/4234e7f4d9b130ef69a0/4039554928628407433?key=yPjW61IwGIydjHnsJnsplQ&expires=1474304029")!
    let videoTitle = "Chưa Một Lần (Cơn Mưa Đến Sau OST) -Nam Cường"
    let videoID = "1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Player", style: .plain, target: self, action: #selector(ViewController.showButtonDidGetTapped))
        view.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
        title = "Plain"
        codeImageView.image = UIImage(named: "PlainExampleCode")
        view.addSubview(codeImageView)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = view.frame.size
        let top = topLayoutGuide.length
        codeImageView.sizeToFit()
        codeImageView.frame.origin.x = (size.width - codeImageView.frame.size.width) / 2
        codeImageView.frame.origin.y = top + (size.height - top - codeImageView.frame.size.height) / 2
    }
    
    func showButtonDidGetTapped() {
        let bundle = Bundle.main
        let config = MobilePlayerConfig(fileURL: bundle.url(
            forResource: "MovielalaPlayer",
            withExtension: "json")!)
        let playerVC = MobilePlayerViewController(
            contentURL: videoURL,
            prerollViewController: PrerollOverlayViewController(),
            pauseOverlayViewController: PauseOverlayViewController(),
            postrollViewController: PostrollOverlayViewController())
        playerVC.title = videoTitle
        playerVC.activityItems = [videoURL as AnyObject]
        present(playerVC, animated: true)
        ProductStore.getProductPlacementsForVideo(
            videoID,
            success: { productPlacements in
                guard let productPlacements = productPlacements else { return }
                for placement in productPlacements {
                    ProductStore.getProduct(placement.productID, success: { product in
                        guard let product = product else { return }
                        playerVC.showOverlayViewController(
                            BuyOverlayViewController(product: product),
                            startingAtTime: placement.startTime,
                            forDuration: placement.duration)
                    })
                }
        })

    }
}

