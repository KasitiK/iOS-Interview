//
//  Loading.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

class Loading {
    private static var backgroundView: UIView?
    private static var loadingIndicator: NVActivityIndicatorView?
    private static var loadingQueue: Int = 0
    
    static func startLoading() {
        // Increase queue count
        loadingQueue += 1
        guard loadingQueue <= 1 else { return }
        guard backgroundView == nil else { return }
        self.backgroundView = UIView(frame: UIScreen.main.bounds)
        self.loadingIndicator = NVActivityIndicatorView(frame: CGRect(origin: self.backgroundView!.center, size: CGSize(width: 50, height: 50)), type: .ballClipRotate, color: UIColor.blue, padding: 0.0)
        backgroundView!.alpha = 0.8
        ///Set background color here
        backgroundView!.backgroundColor = UIColor.black
        backgroundView!.addSubview(loadingIndicator!)
        
        self.loadingIndicator!.translatesAutoresizingMaskIntoConstraints = false
        backgroundView!.addConstraint(NSLayoutConstraint(item: self.loadingIndicator!, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundView!, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0))
        backgroundView!.addConstraint(NSLayoutConstraint(item: self.loadingIndicator!, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: backgroundView!, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0))
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            topController.view.addSubview(backgroundView!)
            self.loadingIndicator!.startAnimating()
        }
    }
    
    static func stopLoading() {
        // Decrease queue count
        loadingQueue -= 1
        if let backgroudViewRef = self.backgroundView, let loadingIndicatorRef = self.loadingIndicator {
            UIView.animate(withDuration: 0.3, animations: {
                DispatchQueue.main.async {
                    backgroudViewRef.alpha = 0
                }
            }) { (_) in
                guard loadingQueue <= 0 else { return }
                loadingIndicatorRef.stopAnimating()
                loadingIndicatorRef.removeFromSuperview()
                backgroudViewRef.removeFromSuperview()
                self.backgroundView = nil
                self.loadingIndicator = nil
            }
        }
    }
}
