//
//  CustomerDetail.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CustomerDetail {
    var id: String?
    var name: String?
    var sex: String?
    var customerGrade: String?
    var isCustomerPremium: Bool?
    
    init(json: JSON) {
        self.id = json["id"].string
        self.name = json["name"].string
        self.sex = json["sex"].string
        self.customerGrade = json["customerGrade"].string
        self.isCustomerPremium = json["isCustomerPremium"].bool
    }
}
