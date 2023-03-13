//
//  APIManager.swift
//  OnlineStore
//
//  Created by dev on 3/12/23.
//

import Foundation


import UIKit
import Alamofire

class APIService {
   
    /**
     Network request to server
     **/
    
    func sendRequest(requestMethod : HTTPMethod, forUrl: String, parameters:[String: Any],
                                   completion: @escaping  (_ result: Data) -> Data){
        print("forUrlforUrl", forUrl)
        
        if requestMethod == .get {
            AF.request(forUrl, method: requestMethod, encoding: JSONEncoding.default).validate()
                .responseJSON { response in
                //return ""
                debugPrint(response)
                Utility.hideLoader()
                if let data = response.data {
                    completion(data)
                }
            }
        } else {
            AF.request(forUrl, method: requestMethod, encoding: JSONEncoding.default).validate()
                .responseJSON { response in
                //return ""
                debugPrint(response)
                Utility.hideLoader()
                if let data = response.data {
                    completion(data)
                }
            }
        }
    }
    

}

