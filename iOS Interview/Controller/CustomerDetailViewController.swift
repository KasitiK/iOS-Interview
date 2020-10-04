//
//  CustomerDetailViewController.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomerDetailViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var customerGreadeLabel: UILabel!
    @IBOutlet weak var customerPremium: UILabel!
    
    // MARK: Variable
    var token: String = ""
    var id: String = ""
    private var customerDetail: CustomerDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
    }
    
    private func requestData() {
        Loading.startLoading()
        Network.requestPOST(url: API.getAPIUrl(.getCustomerDetail),
                            header: HTTPHeader(name: "Content Type", value: "application/json"),
                            parameter: ["token": token,
                                        "customerId": id]
        ) { (response, error) in
            Loading.stopLoading()
            if error == nil {
                let json = JSON(response!)
                self.customerDetail = CustomerDetail(json: json["data"].self)
                self.setupInterface()
            } else {
                self.showAlert(withMessage: error?.localizedDescription ?? "Faild to login", submitActionTitle: "Close")
            }
        }
    }
    
    private func setupInterface() {
        idLabel.text = customerDetail?.id ?? ""
        nameLabel.text = customerDetail?.name ?? ""
        sexLabel.text = customerDetail?.sex ?? ""
        customerGreadeLabel.text = customerDetail?.customerGrade ?? ""
        customerPremium.text = customerDetail?.isCustomerPremium?.description
    }
}
