//
//  Customer.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserDefault: NSObject {
    var responseData: ResponseData?
    
    private static var instance: UserDefault = {
        if let data = UserDefaults.standard.value(forKey: "CurrentData") as? Data {
            let userData = try? PropertyListDecoder().decode(ResponseData.self, from: data)
            return UserDefault(responseData: userData!)
        }
        return UserDefault()
    }()
    
    override init() {
        super.init()
    }
    
    init(responseData: ResponseData) {
        super.init()
        self.responseData = responseData
    }
    
    class func shared() -> UserDefault {
        return self.instance
    }
    
    static func saveUser(withResponseData responseData: ResponseData) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(responseData), forKey: "CurrentData")
        UserDefaults.standard.synchronize()
        self.shared().responseData = responseData
    }
    
    static func logout(vc : UIViewController) {
        vc.showAlert(withMessage: "Do you want to logout?", submitActionTitle: "Yes", cancelActionTitle: "No") {
            self.shared().responseData = nil
            UserDefaults.standard.removeObject(forKey: "CurrentData")
            vc.navigationController?.popViewController(animated: true)
        }
    }
    
}

struct ResponseData: Codable {
    var statu: Int?
    var token: String?
    var customers: [Customer]
    
    init(json: JSON) {
        self.statu = json["status"].int
        self.token = json["token"].string
        self.customers = json["customers"].arrayValue.map({Customer(json: $0)})
    }
}

struct Customer: Codable {
    var id: String?
    var name: String?
    
    init(json: JSON) {
        self.id = json["id"].string
        self.name = json["name"].string
    }
}
