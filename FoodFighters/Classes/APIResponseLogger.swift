//
//  APIResponseLogger.swift
//  FoodFighters
//
//  Created by Corbin Rangler on 9/23/17.
//  Copyright © 2017 Yello. All rights reserved.
//

import Alamofire
import Foundation
import SwiftyJSON

class APIResponseLogger {
    
    class func log<T>(response: DataResponse<T>) {
        
        var statusCode = 0
        
        if let httpResponse = response.response {
            statusCode = httpResponse.statusCode
        }
        else if let nserror = response.result.error as? NSError {
            statusCode = nserror.code
        }
        
        let httpMethod = response.request?.httpMethod ?? ""
        
        var requestURL = response.request?.url?.absoluteString ?? ""
        if let unescapedURL = String(describing: requestURL).removingPercentEncoding {
            requestURL = unescapedURL
        }
        
        print("(\(statusCode)) \(httpMethod) \(requestURL)")
    }
}
