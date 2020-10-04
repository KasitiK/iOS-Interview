//
//  Helper.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(withMessage message: String , title: String? = nil , submitActionTitle: String? , cancelActionTitle: String? = nil , submitHandle: (()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: submitActionTitle , style: .default) { (_) in
            submitHandle?()
        }
        alert.addAction(action)
        if let cancelTitle = cancelActionTitle {
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
