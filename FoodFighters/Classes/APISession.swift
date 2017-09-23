//
//  APISession.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/21/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import Alamofire
import SwiftyJSON

class APISession: NSObject {
    
    struct NetworkResponse {
        
        var json: JSON?
        var isSuccess: Bool = false
        
        init(dataResponse: DataResponse<Any>) {
            
            if let data = dataResponse.data {
                json = JSON(data: data)
            }
            
            if dataResponse.response != nil && json == nil {
                isSuccess = false
                return
            }

            guard let httpResponse = dataResponse.response else {
                isSuccess = false
                return
            }
            
            let statusCode = httpResponse.statusCode
            
            isSuccess = statusCode == 200
        }
    }
    
    var manager: SessionManager
    
    override init() {
        
        //build config with headers
        let configuration = URLSessionConfiguration.default
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func sendRequest(toRoute route: String,
                     method: Alamofire.HTTPMethod = .get,
                     parameters: [String: Any]? = nil,
                     completion: @escaping (NetworkResponse) -> Void) {
        
        //TODO
        let url = ""//baseURL + route
        let encoding: ParameterEncoding = method == .get ? Alamofire.URLEncoding.default : Alamofire.JSONEncoding.default
        
        manager.request(url, method: method, parameters: parameters, encoding: encoding).logAndParseResponse() { networkResponse in
            completion(networkResponse)
        }
    }
}

extension DataRequest {
    
    func logAndParseResponse(completion: @escaping (APISession.NetworkResponse) -> Void) {
        
        responseString() { responseAsString in
            APIResponseLogger.log(response: responseAsString)
            }
            .validate()
            .responseJSON() { responseAsJSON in
                let response = APISession.NetworkResponse(dataResponse: responseAsJSON)
                completion(response)
        }
    }
}
