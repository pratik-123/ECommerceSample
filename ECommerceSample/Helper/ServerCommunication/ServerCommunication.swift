//
//  ServerCommunication.swift
//  ECommerceSample
//
//  Created by Pratik on 18/05/20.
//  Copyright © 2020 Pratik. All rights reserved.
//

import Foundation

/// HTTP method type
enum HTTPMethod {
    case GET,POST,DELETE,PUT
    var value : String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .DELETE:
            return "DELETE"
        case .PUT:
            return "PUT"
        }
    }
}

/// Server communication class
final class ServerCommunication {
    typealias CompletionHandler = ((_ response : ResponseModel?) -> Void)
    
    /// Server communication method to sent or get data
    /// - Parameters:
    ///   - requestObject: request object
    ///   - completionHandler: response block
    func dataTask(requestObject: RequestModel, completionHandler:@escaping CompletionHandler) {
        guard let stringURL = requestObject.url,let serverURL = URL(string: stringURL) else {
            return
        }
        var urlRequest = URLRequest(url: serverURL)
        urlRequest.httpMethod = requestObject.httpMethod.value
        urlRequest.httpBody = requestObject.httpBody
        urlRequest.allHTTPHeaderFields = requestObject.headerFields
        
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data,response,error) in
            if let responseObject = response as? HTTPURLResponse {
                print("statusCode : " + responseObject.statusCode.description)
                let responseModel = ResponseModel(statusCode: responseObject.statusCode, error: error, data: data)
                completionHandler(responseModel)
                return
            }
            completionHandler(nil)
        })
        task.resume()
    }
}

/// Request generate model
struct RequestModel {
    let url: String?
    var httpMethod: HTTPMethod = .GET
    var headerFields: [String : String]? = nil
    var httpBody: Data? = nil
}

/// Response model
struct ResponseModel {
    let statusCode : Int
    let error : Error?
    let data : Data?
}

