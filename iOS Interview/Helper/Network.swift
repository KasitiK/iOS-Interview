//
//  Network.swift
//  iOS Interview
//
//  Created by Kasiti Ketwattha on 4/10/2563 BE.
//  Copyright © 2563 Kasiti Ketwattha. All rights reserved.
//

import Foundation
import Alamofire

var baseUrl = "https://us-central1-iostesting-b3165.cloudfunctions.net/mobileApi/api/v1/"

enum API: String {
    case login = "login"
    case getCustomerDetail = "getCustomerDetail"
    
    static func getAPIUrl(_ api: API) -> String {
        return baseUrl + api.rawValue
    }
}

class Network {
    static func requestPOST(url: String, header: HTTPHeader?, parameter: [String: Any]?, completionHandle: @escaping (_ value: AnyObject?, _ error: Error?) -> ()) {
        AF.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let responseValue):
                print(responseValue)
                completionHandle(responseValue as AnyObject, nil)
            case .failure(let error):
                print(error)
                completionHandle(nil, error)
            }
        }
    }
}
