//
//  LoginViewController.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func requestData() {
        Loading.startLoading()
        Network.requestPOST(url: API.getAPIUrl(.login),
                            header: HTTPHeader(name: "Content Type", value: "application/json"),
                            parameter: ["username": usernameTextField.text ?? "",
                                        "password": passwordTextField.text ?? ""]
        ) { (response, error) in
            Loading.stopLoading()
            if error == nil {
                let json = JSON(response!)
                let responseData = ResponseData(json: json)
                UserDefault.saveUser(withResponseData: responseData)
                self.performSegue(withIdentifier: "Dashboard", sender: nil)
            } else {
                self.showAlert(withMessage: error?.localizedDescription ?? "Faild to login", submitActionTitle: "Close")
            }
        }
    }
    
    
    // MARK: Action
    @IBAction func login(_ sender: Any) {
        guard usernameTextField.text != "" else {
            self.showAlert(withMessage: "Please enter Username", submitActionTitle: "Close")
            return
        }
        guard passwordTextField.text != "" else {
            self.showAlert(withMessage: "Please enter Password", submitActionTitle: "Close")
            return
        }
        
        requestData()
    }
}
