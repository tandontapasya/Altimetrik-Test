//  Created by Tapasya on 23/08/20.
//  Copyright © 2020 Tapasya. All rights reserved.
//

import UIKit

class OverlayActivityIndicator {
    
    static let sharedInstance = OverlayActivityIndicator()
    
    private init() {}
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    public func showOverlayView() {
        
        if let rootViewController = UIApplication.shared.windows.first?.rootViewController {
            overlayView.frame = rootViewController.view.frame
            overlayView.center = rootViewController.view.center
            overlayView.backgroundColor  = .clear
            overlayView.alpha = 1
            
            overlayView.clipsToBounds = true
            overlayView.layer.cornerRadius = 10
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            activityIndicator.style = .large
            activityIndicator.color = .gray
            activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
            
            overlayView.addSubview(activityIndicator)
            rootViewController.view.addSubview(overlayView)
            
            activityIndicator.startAnimating()
        }
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.5, animations: {
            self.overlayView.alpha = 0
            self.overlayView.removeFromSuperview()
        })
    }
}
